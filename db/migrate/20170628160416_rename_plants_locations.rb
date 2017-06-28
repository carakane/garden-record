class RenamePlantsLocations < ActiveRecord::Migration[5.1]
  def change
    rename_table :plantslocations, :plant_locations
  end
end
