class Goal < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user

  def calculate()
    puts created_at
    puts Time.now
  	end_time = created_at + 86400*time
  	if end_time < Time.now
  		return false
  	else
  		return true
  	end
  end
end
