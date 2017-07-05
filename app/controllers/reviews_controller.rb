# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :verify_user_has_logged_in, only: [:index]
  before_action :add_review_for_current_quarter, only: [:index]

  def index
    save_tab_mode 1
    @review_items = current_user.reviews.reverse_order
  end

  private

  def add_review_for_current_quarter
    current_review = current_user.reviews.last
    return unless current_review.nil? ||
                  current_review.name != Review.review_name
    @review = current_user.reviews.build(name: Review.review_name,
                                         mode: Review.modes['started'])
    @review.save
  end
end
