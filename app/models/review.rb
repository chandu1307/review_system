class Review < ApplicationRecord
  belongs_to :user
  has_many :goals
  accepts_nested_attributes_for :goals


  def goals_create
    Goal.where(review_id: id)
  end
end
