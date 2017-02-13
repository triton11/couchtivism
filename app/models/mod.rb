class Mod < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign
end
