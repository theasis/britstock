class AddLocationspecifierToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :locationspecifier, :string
  end
end
