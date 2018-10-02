
# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :verify_user_has_logged_in
  before_action :set_review
  before_action :belongs_to_this_user
  before_action :access, only: [:new, :edit]

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

  def self_rating
    @goal = @review.goal
    @self_rating = @goal.create_self_rating
    check_review_has_goals
  end

  def submit_self_rating
    @goal = @review.goal
    self_rating = @goal.create_self_rating(
      user_id: current_user.id,
      content: params[:feedback],
      rating: params[:self_rating],
      total_rating: 10
    )
    self_rating.save
    save_review_mode
    redirect_to reviews_path
  end

  def submit_feedback
    @goal = @review.goal
    feedback_id = params[:commit].keys[0]
    mesg = params[:manager_feedback]
    if feedback_id != '-1'
      @feedbak = Feedback.find(params[:commit].keys[0])
      @feedbak.update_attributes(user_id: current_user.id, content: mesg)
    else
      @feedbak = @goal.feedbacks.create(user_id: current_user.id, content: mesg)
    end
    if @feedbak.save
      if @review.user.manager_id == current_user.id
        @review.feedback_user_id = @review.user.manager_id
      end
      save_review_mode
      redirect_to_path
    else
      render 'feedback', object: @review
    end
  end

  def feedback
    if @review.completed?
      redirect_to_path
    else
      check_review_has_goals
      @my_feedback = Feedback.where(user_id: current_user.id, goal_id: @goal.id)
      @my_feedback = @my_feedback.present? ? @my_feedback.first : nil
    end
  end

  def show
    unless @review.feedback_user_id.nil?
      @user = User.find(@review.feedback_user_id)
    end
    check_review_has_goals
  end

  def edit
    if @review.started? || @review.saved?
      check_review_has_goals
    else
      flash[:danger] = 'denied access'
      redirect_to root_path
    end
  end

  def new
    @goal = @review.build_goal
  end

  def approve
    save_review_mode
    redirect_to_path
  end

  private

  def save_review_mode
    @review.mode = review_state
    @review.save
  end

  def redirect_to_path
    if tab_mode == 2
      redirect_to team_members_users_path
    elsif tab_mode == 4
      redirect_to all_reviews_users_path
    elsif tab_mode == 5
      redirect_to reviews_by_quarter_users_path
    else
      redirect_to reviews_path
    end
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  def goal_params
    params.require(:goal).permit(:description)
  end

  def belongs_to_this_user
    return if @review.can_be_accessed?(current_user)
    flash[:danger] = 'denied access'
    redirect_to root_path
  end

  def access
    return if @review.belongs_to_user?(current_user)
    flash[:danger] = 'denied access'
    redirect_to root_path
  end

  def belongs_to_this_manager
    return if @review.employee_manager_or_admin?(current_user)
    flash[:danger] = 'denied access'
    redirect_to root_path
  end

  def check_review_has_goals
    @goal = @review.goal
    if !@goal.nil?
      @my_feedback = Feedback.where(user_id: current_user.id, goal_id: @goal.id)
      @my_feedback = @my_feedback.present? ? @my_feedback.first : nil
      @feedbacks = @goal.feedbacks
    else
      flash[:danger] = 'No goals'
      redirect_to reviews_path
    end
  end
end
