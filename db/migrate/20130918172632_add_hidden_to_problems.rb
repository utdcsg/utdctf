class AddHiddenToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :hidden, :boolean
  end
end
