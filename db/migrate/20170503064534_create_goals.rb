class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.text :description
      t.integer :weightage
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
