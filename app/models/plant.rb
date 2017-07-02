class Plant < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_many :plant_locations
  has_many :locations, through: :plant_locations
  has_many :users, through: :locations
end
