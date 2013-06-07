class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :problem_id
      t.integer :category_id

      t.timestamps
    end
  end
end
