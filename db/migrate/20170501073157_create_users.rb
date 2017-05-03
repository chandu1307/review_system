class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar_url
      t.boolean :manager
      t.boolean :admin
      t.integer :manager_id

      t.timestamps
    end
  end
end
