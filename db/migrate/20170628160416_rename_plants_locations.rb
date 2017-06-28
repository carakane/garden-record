class RenamePlantsLocations < ActiveRecord::Migration[5.1]
  def change
    rename_table :plants_locations, :plant_locations
  end
end
