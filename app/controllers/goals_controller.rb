class GoalsController < ApplicationController
  before_action :logged_in_user
  before_action :set_review
  before_action :belongs_to_this_user
  before_action :belongs_to_this_manager, only: [:submit_feedback, :feedback]

  def create
    @goal = @review.build_goal(goal_params)
    if @goal.save
       save_review_mode
       redirect_to reviews_path
    else
      render 'new'
    end
  end

  def update
    @goal = @review.goal
    if @goal.update_attributes(goal_params)
       save_review_mode
       redirect_to reviews_path
    else
      render 'edit'
    end
  end

  def submit_feedback
    @review.feedback_user_id = current_user.id
    @goal = @review.goal
    if @goal.update_attributes(manager_feedback: params[:manager_feedback])
       save_review_mode
       redirect_to_path
    else
      render 'feedback', object: @review
    end
  end

  def feedback
      check_review_has_goals
  end

  def index
    if !@review.feedback_user_id.nil?
     @user =  User.find(@review.feedback_user_id)
    end
    check_review_has_goals
  end

  def edit
    check_review_has_goals
  end

  def new
    @goal = @review.build_goal
  end

  def approve_goals
    save_review_mode
    redirect_to_path
  end

  private

  def save_review_mode
    mode = Review.modes["saved"]
    if params[:commit] == 'Submit for approval'
      mode = Review.modes["submitted"]
    elsif params[:commit] == 'Approve'
        mode = Review.modes["accepted"]
    elsif params[:commit] == 'Submit feedback'
        mode = Review.modes["feedback_submitted"]
    elsif params[:commit] == 'Submit final feedback'
        mode = Review.modes["completed"]
    end
    @review.mode = mode
    @review.save
  end

  def redirect_to_path
    if current_user.id != @review.user.manager_id
       redirect_to all_reviews_users_path
     else
       redirect_to team_members_users_path
     end
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  def goal_params
    params.require(:goal).permit(:description)
  end

  def belongs_to_this_user
   unless can_user_access_review?
     flash[:danger] = "You are not acess that"
     redirect_to root_path
   end
 end

 def belongs_to_this_manager
  unless is_manager_or_admin_for_this_review?
    flash[:danger] = "You are not acess that"
    redirect_to root_path
  end
 end

 def check_review_has_goals
    @goal = @review.goal
   if @goal.nil?
       flash[:danger] = "No goals"
       redirect_to reviews_path
   end
 end
end
