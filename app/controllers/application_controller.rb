class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include UsersHelper

  private

  def verify_user_has_logged_in
    return if logged_in?
    flash[:danger] = 'Please log in.'
    redirect_to root_path
  end
end
