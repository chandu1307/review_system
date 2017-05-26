class Goal < ApplicationRecord
  validates :description,  presence: true
  validates :weightage, presence: true
  belongs_to :review
end
