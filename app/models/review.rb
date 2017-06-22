# frozen_string_literal: true

class Review < ApplicationRecord
  validates :name,  presence: true
  validates :mode,  presence: true
  belongs_to :user
  has_one :goal
  enum mode: %i[started saved submitted accepted feedback_submitted completed]

  def self.review_name
    month_number = Time.zone.now.month
    if month_number <= 3
      'Quarter 1 - ' + Time.zone.now.strftime('%Y')
    elsif month_number <= 6
      'Quarter 2 - ' + Time.zone.now.strftime('%Y')
    elsif month_number <= 9
      'Quarter 3 - ' + Time.zone.now.strftime('%Y')
    elsif month_number <= 12
      'Quarter 4 - ' + Time.zone.now.strftime('%Y')
    end
  end
end
