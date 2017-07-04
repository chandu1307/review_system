class AddManagerFeedbackToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :manager_feedback, :string
  end
end
