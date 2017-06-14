class Goal < ApplicationRecord

  #TODO: Capture the category for the goal - Ex: Learning, BC

  validates :description,  presence: true
  belongs_to :review
end
