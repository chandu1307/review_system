class User < ApplicationRecord
  validates :name,  presence: true
  validates :email, presence: true
  has_many :reviews, dependent: :destroy
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    user = User.create(
        name: data['first_name']+" " + data['last_name'],
        email: data['email'],
        avatar_url: data['image'],
        manager: false,
        admin: false,
    ) unless user

    user
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  private


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
