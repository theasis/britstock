class AddNameAndDescriptionToLightboxes < ActiveRecord::Migration
  def change
    add_column :lightboxes, :name, :string
    add_column :lightboxes, :description, :string
  end
end
