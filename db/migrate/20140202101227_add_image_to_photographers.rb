class AddImageToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :image, :string
  end
end
