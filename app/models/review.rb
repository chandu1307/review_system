class Review < ApplicationRecord
  validates :name,  presence: true
  belongs_to :user
  has_many :goals
  accepts_nested_attributes_for :goals
  enum mode: [:saved, :submitted, :accepted]


  # TODO: Get rid of get_review_name once you capture the quarter value in the form.

  def self.get_review_name
    name  = ""
    month_number = Time.now.month

    if month_number <= 3
      name = name + "Quarter 1 - " + Time.now.strftime("%Y")
    elsif month_number <= 6
      name =  name + "Quarter 2 - " + Time.now.strftime("%Y")
    elsif month_number <= 9
      name =  name + "Quarter 3 - " + Time.now.strftime("%Y")
    elsif month_number <= 12
      name =  name + "Quarter 4 - " + Time.now.strftime('%Y')
    end
    return name
  end

  def save_review_and_goals(goals_attributes:)
    is_saved = false

     begin
       self.transaction do
         self.save!
         goals = self.goals.build(goals_attributes)

         if(goals.size>0)
            if self.goals.map(&:weightage).sum == 100
              goals.each do|goal|
                if goal.new_record?
                   goal.save!
                else
                   Goal.where(id: goal["id"]).update(description: goal["description"], weightage: goal["weightage"])
                end
              end
              is_saved = true
           else
            errors.add(:base, :blank, message: "Total weightage must be 100")
            raise ActiveRecord::Rollback, "Total weightage must be 100"
         end
        else
           errors.add(:base, :blank, message: "Need at least one goal")
           raise ActiveRecord::Rollback, "Need at least one goal"
        end
       end
     rescue
       is_saved = false
     end
    return is_saved
  end
end
