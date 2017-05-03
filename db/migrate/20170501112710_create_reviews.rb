class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :name
      t.references :user, foreign_key: true
      t.boolean :submitted
      t.boolean :approved

      t.timestamps
    end
  end
end
