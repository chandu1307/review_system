class UsersController < ApplicationController
  before_action :if_user_is_logged_in, only: [:new ,:create]



  def create
    user = User.from_omniauth(env["omniauth.auth"])
    log_in user
    redirect_to reviews_path
  end

  def index

    @users = User.all

  end


  def destroy
    log_out if logged_in?
    redirect_to root_path

  end



  def team_leads
    users = params[:managers].keys
    managers = params[:managers].values;
    User.update_all(manager: false)

    i = 0

    users.each do|user_id|
      User.where(id: managers[i]).update_all(manager: true)
      User.where(id: user_id).update(manager_id: managers[i])
      i= i+1;
    end
    redirect_to reviews_path
  end




  def if_user_is_logged_in
    redirect_to reviews_path if logged_in?
  end

  def reviews
      @review_items = Review.where(["user_id = ? and mode != ?", params[:id], 0])
      @user = User.where(id: params[:id])
  end






end
