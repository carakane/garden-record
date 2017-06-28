class User < ActiveRecord::Base
  has_secure_password
  has_many :locations
  has_many :plants, through: :locations
end
