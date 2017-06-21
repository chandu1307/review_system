class User < ApplicationRecord
  validates :name,  presence: true
  validates :email, presence: true
  has_many :reviews, dependent: :destroy

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])
    user = User.create(
        name: data['first_name'] + ' ' + data['last_name'],
        email: data['email'],
        avatar_url: data['image'],
        manager: false,
        admin: false
    ) unless user
    user
  end
end
