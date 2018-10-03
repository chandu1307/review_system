# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :if_user_is_logged_in, only: [:new, :create]
  before_action :verify_user_has_logged_in, only:
   [:index, :team_members, :all_reviews, :all_reviews_by_quarter]
  before_action :verify_user_as_admin, only:
   [:index, :all_reviews, :all_reviews_by_quarter, :team_leads]
  before_action :verify_user_as_manager, only: [:team_members]

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    if !user.id.nil?
      log_in user
      redirect_to reviews_path
    else
      flash[:danger] = 'Please login with beautifulcode email'
      redirect_to root_path
    end
  end

  def index
    save_tab_mode 3
    @users = User.all
  end

  def team_hierarchy
    @users = User.all
  end

  def logout
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

  def verify_user_as_admin
    return if current_user.admin?
    flash[:danger] = 'denied access'
    redirect_to root_path
  end

  def team_members
    save_tab_mode 2
    @users = User.where(manager_id: current_user.id).eager_load(:reviews)
  end

  def all_reviews
    save_tab_mode 4
    @users = User.all.eager_load(:reviews)
  end

  def reviews_by_quarter
    save_tab_mode 5
    @reviews_hash = Review.all.eager_load(
      :user, goal: [:feedbacks]
    ).group_by(&:name)
  end

  def verify_user_as_manager
    return if current_user.manager?
    flash[:danger] = 'denied access'
    redirect_to reviews_path
  end
end
