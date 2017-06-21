class Review < ApplicationRecord
  validates :name,  presence: true
  validates :mode,  presence: true
  belongs_to :user
  has_one :goal
  enum mode: [ :started, :saved, :submitted, :accepted, :feedback_submitted, :completed]

  def self.get_review_name
    name = ''
    month_number = Time.now.month
    if month_number <= 3
      name = name + 'Quarter 1 - ' + Time.now.strftime('%Y')
    elsif month_number <= 6
      name =  name + 'Quarter 2 - ' + Time.now.strftime('%Y')
    elsif month_number <= 9
      name =  name + 'Quarter 3 - ' + Time.now.strftime('%Y')
    elsif month_number <= 12
      name =  name + 'Quarter 4 - ' + Time.now.strftime('%Y')
    end
    return name
  end
end
