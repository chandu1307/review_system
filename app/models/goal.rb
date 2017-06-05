class Goal < ApplicationRecord

  #TODO: Capture the category for the goal - Ex: Learning, BC

  validates :description,  presence: true
  validates :weightage, presence: true
  belongs_to :review
end
