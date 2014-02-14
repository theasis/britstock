class AddLatitudeAndLongitudeToMarkers < ActiveRecord::Migration
  def change
    add_column :markers, :latitude, :float
    add_column :markers, :longitude, :float
  end
end
