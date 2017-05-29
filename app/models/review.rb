class Review < ApplicationRecord
  validates :name,  presence: true
  belongs_to :user
  has_many :goals
  accepts_nested_attributes_for :goals
  enum mode: [:saved, :submitted, :accepted]





  private
    def check_total_weightage
      unless self.goals.map(&:weightage).sum == 100
         errors.add(:weightage, "Total weightage must be 100")
       end
     end

end
