class AddContentToMapLocations < ActiveRecord::Migration
  def change
    add_column :map_locations, :content, :text
  end
end
