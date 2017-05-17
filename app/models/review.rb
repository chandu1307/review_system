class Review < ApplicationRecord
  belongs_to :user
  has_many :goals
  accepts_nested_attributes_for :goals

  enum mode: [:saved, :submitted, :accepted]



  def goals_create
    Goal.where(review_id: id)
  end
end
