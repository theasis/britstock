class AddExampleimageToLightboxes < ActiveRecord::Migration
  def change
    add_column :lightboxes, :exampleimage, :integer
  end
end
