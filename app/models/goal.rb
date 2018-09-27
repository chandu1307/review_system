# frozen_string_literal: true

class Goal < ApplicationRecord
  validates :description, presence: true
  belongs_to :review
  has_many :feedbacks
  has_one :self_rating
end
