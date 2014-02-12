class AddFilecountToCaches < ActiveRecord::Migration
  def change
    add_column :caches, :filecount, :integer
  end
end
