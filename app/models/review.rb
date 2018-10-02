# frozen_string_literal: true

class Review < ApplicationRecord
  validates :name, :mode, presence: true
  belongs_to :user
  has_one :goal
  enum mode: %i[started saved submitted accepted feedback_submitted
                self_rating_submitted completed]

  def self.review_name
    time_now = Time.zone.now + 20.days
    month_number = time_now.month
    year = time_now.strftime('%Y')
    if month_number <= 3
      'Jan ' + year + ' - March ' + year
    elsif month_number <= 6
      'April ' + year + ' - June ' + year
    elsif month_number <= 9
      'July ' + year + ' - Sep ' + year
    elsif month_number <= 12
      'Oct ' + year + ' - Dec ' + year
    end
  end

  def can_be_accessed?(user)
    user.admin || user_id == user.id || self.user.manager_id == user.id
  end

  def belongs_to_user?(user)
    user_id == user.id
  end

  def employee_manager_or_admin?(user)
    user.admin || self.user.manager_id == user.id
  end
end
