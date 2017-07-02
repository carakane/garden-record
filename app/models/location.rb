class Location < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  belongs_to :user
  has_many :plant_locations
  has_many :plants, through: :plant_locations
end
