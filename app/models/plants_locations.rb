class PlantLocation < ActiveRecord::Base
  belongs_to :locations
  belongs_to :plants
end
