class UsersController < ApplicationController
  before_action :if_user_is_logged_in, only: [:new ,:create]



  def create
    user = User.from_omniauth(env["omniauth.auth"])
    log_in user
    redirect_to reviews_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path

  end



  def if_user_is_logged_in

    redirect_to reviews_path if logged_in?


  end

  def reviews
    Review.where(user_id: id)
  end




end
