class CreateSelfRating < ActiveRecord::Migration[5.1]
  def change
    create_table :self_ratings do |t|
      t.text :content
      t.integer :user_id
      t.integer :goal_id
      t.integer :rating
      t.integer :total_rating
    end
  end
end
