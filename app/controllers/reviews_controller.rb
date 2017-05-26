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
    mode = Review.modes["saved"]
    if params[:commit] == 'Submit'
      mode = Review.modes["submitted"]
    end

    review = current_user.reviews.build(name: get_review_name, mode: mode)


    if review.save
      goals = review.goals.build(params[:review][:goals_attributes].values);
      goals.each do|goal|
        goal.save
      end
      flash[:success] = "Review created!"
      redirect_to reviews_path

    else
      flash[:success] = "Total weightage must be 100"
      redirect_to reviews_path
    end

  end

  def update
    @review = Review.find(params[:id])
    current_mode = Review.modes["saved"]
    if params[:commit] == 'Submit'
      current_mode = Review.modes["submitted"]
    end
    if @review.update(mode: current_mode)
        goals = params[:review][:goals_attributes].values


        goals.each do|goal|
            Goal.where(id: goal["id"]).update(description: goal["description"], weightage: goal["weightage"])
        end

        redirect_to reviews_path



    end

  end



  def index
    @review_items = current_user.reviews.paginate(page: params[:page])

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
