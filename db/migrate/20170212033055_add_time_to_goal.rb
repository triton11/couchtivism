class AddTimeToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :time, :integer
  end
end
