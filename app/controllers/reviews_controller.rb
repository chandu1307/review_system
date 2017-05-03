class ReviewsController < ApplicationController

  before_action :logged_in_user, only: [:index,:new ,:show]

  def show


  end
  def new


  end

  def index
    @review_items = current_user.reviews.paginate(page: params[:page])

  end





  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end

end