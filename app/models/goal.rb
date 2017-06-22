# frozen_string_literal: true

class Goal < ApplicationRecord
  validates :description, presence: true
  belongs_to :review
end
