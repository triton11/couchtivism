class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :campaign, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.integer :points
      t.string :typed

      t.timestamps null: false
    end
  end
end
