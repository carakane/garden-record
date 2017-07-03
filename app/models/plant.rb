class Plant < ActiveRecord::Base
  validates :name, presence: true
  has_many :plant_locations
  has_many :locations, through: :plant_locations
  belongs_to :user
end
