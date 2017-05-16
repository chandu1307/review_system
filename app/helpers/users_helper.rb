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


  # Returns true if the user is logged in, false otherwise.
  def is_access?
    @review = Review.find(params[:id])
    if(!@review.nil?)
       @review_user =  User.find_by(id: @review.user_id)
     end
    if((!current_user.nil? && (@review.user_id ==current_user.id)||(!@review_user.nil? && @review_user.manager_id==current_user.id)))
      return true
    end
    return false

  end


end
