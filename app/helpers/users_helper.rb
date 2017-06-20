module UsersHelper
  # Logs in the given user.
  def log_in(user)
    if user != nil
      session[:user_id] = user.id
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      user ||= User.find_by(id: user_id)
      log_in user
      @current_user = user
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      log_in user
      @current_user = user
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    cookies.delete(:user_id)
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  def is_admin?
    if !current_user.nil? &&current_user.admin
      return true
    end
    return false

  end

  def is_access?
    @review = Review.find(params[:review_id])
    if(!@review.nil?)
      @review_user =  User.find_by(id: @review.user_id)
    end
    if((!current_user.nil? && (@review.user_id ==current_user.id)||(!@review_user.nil? && @review_user.manager_id==current_user.id)))
      return true
    end
    return false
  end

  def is_manager_for_this_review?
    @review = Review.find(params[:review_id])
    if(!@review.nil?)
      @review_user =  User.find_by(id: @review.user_id)
    end
    if((!current_user.nil? && (!@review_user.nil? && @review_user.manager_id==current_user.id)))
      return true
    end
    return false
  end

  def is_manager?
    if (!current_user.nil? && current_user.manager)
      return true
    end
    return false
  end


  def get_user_status(review_state)
   status_message = case review_state
   when "started" then "Create goals for this quarter after discussion with team lead"
   when "saved" then "Submit goals for manager's approval"
   when "submitted" then "Waiting for manager's approval"
   when "accepted" then "Manager has approved your goals, waiting for feedback"
   when "feedback_submitted" then "Manager has given feedback"
   when "completed" then "Manager has given final feedback"
   else review_state
   end
   return status_message
  end


  def get_manager_status(review_state)
   status_message = case review_state
   when "started" then "Discuss with reportee for creation of goals"
   when "saved" then "Discuss with reportee for creation of goals"
   when "submitted" then "Goals submitted, waiting for your approval"
   when "accepted" then "Provide feedback"
   when "feedback_submitted" then "Submit your final feedback"
   when "completed" then "You have provided feedback"
   else review_state
   end
   return status_message
  end

  def get_user_action(review_state)
    action  = case review_state
   when "started" then "create"
   when "saved" then "submit"
   else "view"
   end
   return action
  end

  def get_manager_action(review_state)
    action  = case review_state
   when "accepted" then "submit feedback"
   when "feedback_submitted" then "submit feedback"
   when "submitted" then "view"
   else "view"
   end
   return action
  end
end
