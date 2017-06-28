class PlantLocation < ActiveRecord::Base
  belongs_to :location
  belongs_to :plant
end
