class GoalsController < ApplicationController
  before_action :logged_in_user
  before_action :set_review
  before_action :belongs_to_this_user

  def create
    @review.mode = get_review_mode
    @review.save
    @goal = @review.build_goal(goal_params)
    if @goal.save
       redirect_to reviews_path
    else
      render 'new', object: review
    end
  end

  def update
    @review.mode = get_review_mode
    @review.save
    @goal = @review.goal
    if @goal.update_attributes(goal_params)
      redirect_to reviews_path
    else
      render 'edit', object: [@review,@goal]
    end
  end

  def submit_feedback
    @review.mode = get_review_mode
    @review.feedback_user_id = current_user.id
    @review.save
    @goal = @review.goal
    if @goal.update_attributes(manager_feedback: params[:manager_feedback])
      redirect_to team_members_user_path(current_user)
    else
      render 'feedback', object: [@review,@goal]
    end
  end


  def feedback
    @goal = @review.goal
  end

  def show
    if !@review.feedback_user_id.nil?
     @user =  User.find(@review.feedback_user_id)
    end
    @goal = @review.goal
  end

  def edit

    @goal = @review.goal
  end

  def new

    @goal = @review.build_goal
  end

  def approve_goals
    @review.mode = get_review_mode
    @review.save
    redirect_to team_members_user_path(current_user)
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
    elsif params[:commit] == 'Save Feedback'
        mode = Review.modes["feedback_saved"]
    elsif params[:commit] == 'Submit Feedback'
        mode = Review.modes["feedback_submitted"]
    end
    return mode
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  private

  def goal_params
    params.require(:goal).permit(:description)
  end

  def goal_params_feedback
    params.require(:goal).permit(:manager_feedback)
  end

  def belongs_to_this_user

   unless is_access?
     flash[:danger] = "You are not acess that"
     redirect_to root_path
   end
 end

end
