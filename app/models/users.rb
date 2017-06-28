class User < ActiveRecord::Base
  has_secure_password
  has_many :locations
  has many :plants, through: :locations
end
