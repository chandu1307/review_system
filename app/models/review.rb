class Review < ApplicationRecord
  belongs_to :user
  has_many :goals
  accepts_nested_attributes_for :goals
end
