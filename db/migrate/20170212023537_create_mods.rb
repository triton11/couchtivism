class CreateMods < ActiveRecord::Migration
  def change
    create_table :mods do |t|
      t.references :user, index: true, foreign_key: true
      t.references :campaign, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
