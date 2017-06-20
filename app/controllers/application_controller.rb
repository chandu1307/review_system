class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include UsersHelper
  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end
end
