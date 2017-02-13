class User < ActiveRecord::Base
	include BCrypt
  has_many :campaigns_users
  has_many :campaigns, through: :campaigns_users
  has_many :mods
  has_many :campaigns, through: :mods
  validates :email, confirmation: true
  validates :email_confirmation, presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }
  validates :password_hash, length: { minimum: 6 }, confirmation: true
  validates :password_hash_confirmation, presence: true, on: :create


	def password
  	unless password_hash == nil 
      password ||= Password.new(password_hash)
    end
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end
end
