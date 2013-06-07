class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :description
      t.integer :points
      t.boolean :active
      t.string :flag
      t.string :title

      t.timestamps
    end
  end
end
