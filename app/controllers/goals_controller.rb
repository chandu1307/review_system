class GoalsController < ApplicationController
  before_action :logged_in_user
  before_action :set_review
  before_action :belongs_to_this_user
  before_action :belongs_to_this_manager, only: [:submit_feedback, :feedback]

  def create
    @review.mode = get_review_mode
    @goal = @review.build_goal(goal_params)
    if @goal.save
       @review.save
       redirect_to reviews_path
    else
      render 'new', object: @review
    end
  end

  def update
    @review.mode = get_review_mode
    @goal = @review.goal
    if @goal.update_attributes(goal_params)
       @review.save
       redirect_to reviews_path
    else
      render 'edit', object: [@review,@goal]
    end
  end

  def submit_feedback
    @review.mode = get_review_mode
    @review.feedback_user_id = current_user.id
    @goal = @review.goal
    if @goal.update_attributes(manager_feedback: params[:manager_feedback])
       @review.save
       redirect_to team_members_users_path
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
    @review.mode = get_review_mode
    @review.save
    redirect_to team_members_users_path
  end

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end

  def get_review_mode
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
    return mode
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  def goal_params
    params.require(:goal).permit(:description)
  end

  def belongs_to_this_user
   unless is_access?
     flash[:danger] = "You are not acess that"
     redirect_to root_path
   end
 end

 def belongs_to_this_manager
  unless is_manager_for_this_review?
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
