class RemoveweightageFromgoals < ActiveRecord::Migration[5.1]
  def change
    remove_column :goals, :weightage, :integer
  end
end
