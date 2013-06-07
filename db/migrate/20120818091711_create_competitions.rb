class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.datetime :start
      t.datetime :end
      t.boolean :active

      t.timestamps
    end
  end
end
