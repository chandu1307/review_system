class RemoveColumnFromReview < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :submitted, :boolean
    remove_column :reviews, :approved, :boolean
  end
end
