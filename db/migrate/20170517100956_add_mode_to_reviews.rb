class AddModeToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :mode, :integer
  end
end
