# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :if_user_is_logged_in, only: %i[new create]
  before_action :user_is_admin, only: %i[index all_reviews]
  before_action :user_is_manager, only: %i[team_members]
  before_action :logged_in_user, only: %i[index team_members all_reviews]
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
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
    managers = params[:managers].values
    User.where(manager: true).find_each { |u| u.update(manager: false) }
    users.each.with_index do |user_id, index|
      User.where(id: managers[index]).update(manager: true)
      User.where(id: user_id).update(manager_id: managers[index])
    end
    redirect_to reviews_path
  end

  def if_user_is_logged_in
    redirect_to reviews_path if logged_in?
  end

  def user_is_admin
    return if current_user.admin?
    flash[:danger] = "You don't have access"
    redirect_to root_path
  end

  def reviews
    @team_member = User.find(params[:id])
    @review_items = Review.where(['user_id = ? and mode != ?', params[:id], 0])
  end

  def team_members
    @users = User.where(manager_id: current_user.id)
  end

  def all_reviews
    @users = User.all
  end

  def user_is_manager
    return if current_user.manager?
    flash[:danger] = "You don't have access"
    redirect_to reviews_path
  end
end
