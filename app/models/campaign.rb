class Campaign < ActiveRecord::Base
	has_many :campaigns_users
	has_many :users, through: :campaigns_users
  has_many :mods
  has_many :points
  has_many :users, through: :mods
  has_many :goals

  def self.search(search)
    if search
      where("title like ?", "%#{@search}%")
    else
      find(:all)
    end
  end
end
