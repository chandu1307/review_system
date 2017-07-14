class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.integer :user_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
