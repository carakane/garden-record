class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_many :locations
  has_many :plants, through: :locations
end
