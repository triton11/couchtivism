class AddEmailToMod < ActiveRecord::Migration
  def change
    add_column :mods, :email, :string
  end
end
