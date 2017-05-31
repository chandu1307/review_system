class Review < ApplicationRecord
  validates :name,  presence: true
  belongs_to :user
  has_many :goals
  accepts_nested_attributes_for :goals
  enum mode: [:saved, :submitted, :accepted]



  def self.get_review_name
    name  = ""
    if  Time.now.month < 3
      name = name + "Quarter 1 - "+Time.now.strftime("%Y")
    elsif  Time.now.month < 6
      name =  name + "Quarter 2 - "+Time.now.strftime("%Y")
    elsif  Time.now.month < 8
      name =  name +"Quarter 3 - "+ Time.now.strftime("%Y")
    else
      name =  name +"Quarter 4 - "+Time.now.year
    end
    return name
  end

  def save_review_and_goals(goals_attributes:)
    isSaved = false
    self.transaction do
      self.save!
      goals = self.goals.build(goals_attributes)
      if self.goals.map(&:weightage).sum == 100
        goals.each do|goal|
          goal.save!
        end
          isSaved = true
       else
         isSaved = false;
         raise ActiveRecord::Rollback, "Total weightage must be 100"
      end
    end
  end

  def update_review_and_goals(goals_attributes:)
    isSaved = false
    self.transaction do
      self.update!
      goals = self.goals.build(goals_attributes)
      if self.goals.map(&:weightage).sum == 100
        goals.each do|goal|
          goal.save!
        end
          isSaved = true
       else
         isSaved = false;
         raise ActiveRecord::Rollback, "Total weightage must be 100"
      end
    end
  end

  def update_review_status(mode:)
    self.update(mode: mode)
  end




end
