class ReviewsController < ApplicationController

  before_action :logged_in_user, only: [:index,:new ,:show,:edit]
  before_action :belongs_to_this_user,only: [:show,:edit]
  before_action :set_review, only: [:show, :edit, :update]
  before_action :allow_to_add_review, only: [:new, :create ]

  def show
    @goal_items = @review.goals
  end

  def edit
  end

  def new
    @review = Review.new
    (1..4).each { @review.goals.build }
  end


  def create

    review = current_user.reviews.build(name: Review.get_review_name, mode: get_review_mode)
    isSaved = review.save_review_and_goals(goals_attributes: params[:review][:goals_attributes].values)
     if(isSaved)
       flash[:success] = "Review created!"
       redirect_to reviews_path
     else
       flash[:success] = "Total weightage must be 100"
       redirect_to reviews_path

     end
  end

  def update
    @review.mode = get_review_mode
    isSaved = @review.save_review_and_goals(goals_attributes: params[:review][:goals_attributes].values)
    if isSaved
        redirect_to reviews_path
      else
        flash[:success] = "Total weightage must be 100"
        redirect_to reviews_path

    end
  end



  def index
    @review_items = current_user.reviews
    @users = User.where(:manager_id => current_user.id)
  end

  def approve_goals
    review_id = params[:edit].keys
    value = params[:edit].values;
    mode = Review.modes["saved"]
    if value[0] == 'Approve'
      mode = Review.modes["accepted"]
    end
    Review.where(id: review_id[0]).update(mode: mode)
    redirect_to reviews_path
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

  def allow_to_add_review
    unless is_allow?
      flash[:danger] = "You can't create new review"
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

  def set_review
    @review = Review.find(params[:id])
  end


  def get_review_mode
    mode = Review.modes["saved"]
    if params[:commit] == 'Submit'
      mode = Review.modes["submitted"]
    end
    return mode
  end





end
