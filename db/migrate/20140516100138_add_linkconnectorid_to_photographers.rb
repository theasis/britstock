class AddLinkconnectoridToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :linkconnectorid, :integer
  end
end
