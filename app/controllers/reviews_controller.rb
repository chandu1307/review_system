class ReviewsController < ApplicationController

  before_action :logged_in_user, only: [:index,:new ,:show,:edit]
  before_action :belongs_to_this_user,only: [:show,:edit]

  def show
    @review = Review.find(params[:id])
    @goal_iteams = @review.goals.paginate(page: params[:page])
  end


  def edit
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    (1..4).each { @review.goals.build }
  end


  def create
    submitted_value = false
    if params[:commit] == 'Submit'
      submitted_value = true
    end
    review = current_user.reviews.build(name: get_review_name, submitted: submitted_value, approved: false)
    if review.save
      goals = review.goals.build(params[:review][:goals_attributes].values);
      goals.each do|goal|
        goal.save
      end
      flash[:success] = "Review created!"
      redirect_to reviews_path

    else
      render reviews_path
    end

  end

  def update
    @review = Review.find(params[:id])
    submitted_value = false
    if params[:commit] == 'Submit'
      submitted_value = true
    end
    if @review.update(submitted: submitted_value)
        goals = params[:review][:goals_attributes].values
        goals.each do|goal|
          goal.update(goal)
        end

        redirect_to reviews_path



    end

  end



  def index
    @review_items = current_user.reviews.paginate(page: params[:page])
    @users = User.where(:manager_id => current_user.id)

  end





  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end

  def belongs_to_this_user
    unless is_access?
      flash[:danger] = "You are not acess that"
      redirect_to root_path
    end
  end

  def review_params
    params.require(:review).permit(:name, :submitted, :approved)
  end

  def goals_params_require(params)

    params.require(:goal).permit(:description, :weightage)
  end


  private

  def get_review_name

    name  = ""
    if  Time.now.month < 3
      name = name + "Quarter 1 - "+Time.now.strftime("%Y")
    elsif  Time.now.month < 6
      name =  name + "Quarter 2 - "+Time.now.strftime("%Y")
    elsif  Time.now.month < 8
      name =  name +"Quarter 3 - "+ Time.now.strftime("%Y")
    else
      name =  name +"Quarter 4 - "+Time.now.year
    end
    return name
  end



end

