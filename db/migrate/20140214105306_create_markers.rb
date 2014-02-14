class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.string :label
      t.string :position

      t.timestamps
    end
  end
end
