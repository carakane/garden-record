class CreatePlantsLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :plant_locations do |t|
      t.integer :plant_id
      t.integer :location_id
    end
  end
end
