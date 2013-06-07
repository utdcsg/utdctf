class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :ip

      t.timestamps
    end
  end
end
