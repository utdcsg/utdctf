class AddHiddenToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :hidden, :boolean
  end
end
