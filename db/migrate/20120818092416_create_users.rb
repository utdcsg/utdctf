class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :role
      t.string :name
      t.text :description
      t.string :hashed_password
      t.string :salt
      t.datetime :last_submission
      t.datetime :locked
      t.integer :flood_count

      t.timestamps
    end
  end
end
