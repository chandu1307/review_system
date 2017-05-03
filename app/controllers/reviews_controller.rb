class ReviewsController < ApplicationController

  before_action :logged_in_user, only: [:index,:new ,:show]

  def show


  end
  def create

    @review = current_user.reviews.build(name: get_review_name, submitted: false, approved: false)
    if @review.save
      debugger
      flash[:success] = "Review created!"
      redirect_to reviews_path
    else
      render reviews_path
    end
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

  def review_params
    params.require(:review).permit(:name, :submitted, :approved)
  end

  def get_review_name
    date = Time.now.strftime("%Y%m")
    if  Time.now.month < 3
      return "Quarter 1 - "+date.year
    elsif  Time.now.month < 6
      return "Quarter 2 - "+date.year
    elsif  Time.now.month < 8
      return "Quarter 3 - "+date.year
    else
       return "Quarter 4 - "+date.year
    end
  end


  def get_review_name

    name  = ""
    if  Time.now.month < 3
      name = name + "Quarter 1 - "+Time.now.strftime("%Y")
    elsif  Time.now.month < 6
      name =  name + "Quarter 2 - "+Time.now.strftime("%Y")
    elsif  Time.now.month < 8
      name =  name +"Quarter 3 - "+ Time.now.strftime("%Y")
    else
      name =  name +"Quarter 4 - "+Time.now.strftime("%Y")
    end
    return name
  end
end

