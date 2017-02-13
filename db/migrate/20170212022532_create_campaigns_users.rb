class CreateCampaignsUsers < ActiveRecord::Migration
  def change
    create_table :campaigns_users do |t|
      t.references :campaign, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
