class GoalsController < ApplicationController
  before_action :logged_in_user, only: [:index,:new ,:show,:edit]
  before_action :set_review, only: [:create,:update ,:submit_feedback,:feedback, :show, :edit, :new, :approve_goals]


  def create
    @review.mode = get_review_mode
    @review.save
    @goal = @review.build_goal(goal_params)
    @goal.save
    redirect_to reviews_path
  end

  def update
    @review.mode = get_review_mode
    @review.save
    @goal = @review.goal
    if @goal.update_attributes(goal_params)
      redirect_to reviews_path
    else
      render 'edit'
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
      render 'feedback'
    end
  end


  def feedback
    @goal = @review.goal
  end

  def show
    @user =  User.find(@review.feedback_user_id)
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
    redirect_to reviews_path
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
    if params[:commit] == 'Submit'
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

end
