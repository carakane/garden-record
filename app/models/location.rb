class Location < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :user
  has_many :plant_locations
  has_many :plants, through: :plant_locations
end
