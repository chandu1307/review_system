class GoalsController < ApplicationController

  def create
    @goal = current_user.reviews.build(review_params)
    if @goal.save

    end
  end


    def show
      @review = Review.find(params[:id])
      @goals = @review.goals.paginate()

    end



end