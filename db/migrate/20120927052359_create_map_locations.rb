class CreateMapLocations < ActiveRecord::Migration
  def change
    create_table :map_locations do |t|
      t.string :xval
      t.string :yval

      t.timestamps
    end
  end
end
