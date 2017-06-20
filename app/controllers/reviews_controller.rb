class ReviewsController < ApplicationController

  before_action :logged_in_user, only: [:index]
  before_action :add_review_for_current_quarter, only: [:index ]

  def index
    @review_items = current_user.reviews
  end

private
  def add_review_for_current_quarter
       current_review = current_user.reviews.last
       if(current_review.nil? || current_review.name != Review.get_review_name)
         @review = current_user.reviews.build(name: Review.get_review_name, mode: Review.modes["started"])
         @review.save
       end
  end
  
  def belongs_to_this_user
    unless is_access?
      flash[:danger] = "You are not acess that"
      redirect_to root_path
    end
  end
end
