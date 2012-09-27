class AddTitleToMapLocations < ActiveRecord::Migration
  def change
    add_column :map_locations, :title, :string
  end
end
