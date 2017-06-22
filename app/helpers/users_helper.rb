# frozen_string_literal: true

module UsersHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id unless user.nil?
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if !session[:user_id].nil?
      user ||= User.find_by(id: session[:user_id])
      log_in user
      @current_user = user
    elsif !cookies.signed[:user_id].nil?
      user = User.find_by(id: cookies.signed[:user_id])
      log_in user
      @current_user = user
    end
  end

  def current_user?(user)
    user == current_user
  end

  def log_out
    forget
    session.delete(:user_id)
    @current_user = nil
  end

  def forget
    cookies.delete(:user_id)
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def logged_in?
    !current_user.nil?
  end

  def user_status(review_state)
    case review_state
    when 'started' then 'Create goals for this quarter after discussion with
      team lead'
    when 'saved' then "Submit goals for manager's approval"
    when 'submitted' then "Waiting for manager's approval"
    when 'accepted' then 'Manager has approved your goals, waiting for feedback'
    when 'feedback_submitted' then 'Manager has given feedback'
    when 'completed' then 'Manager has given final feedback'
    else review_state
    end
  end

  def manager_status(review_state)
    case review_state
    when 'started' then 'Discuss with reportee for creation of goals'
    when 'saved' then 'Discuss with reportee for creation of goals'
    when 'submitted' then 'Goals submitted, waiting for your approval'
    when 'accepted' then 'Provide feedback'
    when 'feedback_submitted' then 'Submit your final feedback'
    when 'completed' then 'You have provided feedback'
    else review_state
    end
  end

  def user_action(review_state)
    case review_state
    when 'started' then 'create'
    when 'saved' then 'submit'
    else 'view'
    end
  end

  def manager_action(review_state)
    case review_state
    when 'accepted' then 'submit feedback'
    when 'feedback_submitted' then 'submit feedback'
    when 'submitted' then 'view'
    else 'view'
    end
  end

  def review_state
    if params[:commit] == 'Submit for approval'
      Review.modes['submitted']
    elsif params[:commit] == 'Approve'
      Review.modes['accepted']
    elsif params[:commit] == 'Submit feedback'
      Review.modes['feedback_submitted']
    elsif params[:commit] == 'Submit final feedback'
      Review.modes['completed']
    else
      Review.modes['saved']
    end
  end
end
