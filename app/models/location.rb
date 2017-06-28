class Location < ActiveRecord::Base
  belongs_to :user
  has_many :plant_locations
  has_many :plants, through: :plant_locations
end
