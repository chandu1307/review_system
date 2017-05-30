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

  private
    def check_total_weightage
      unless self.goals.map(&:weightage).sum == 100
         errors.add(:weightage, "Total weightage must be 100")
       end
     end

end
