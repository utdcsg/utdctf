class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.integer :person_id
      t.integer :user_id

      t.timestamps
    end
  end
end
