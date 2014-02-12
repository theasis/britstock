class ChangeDataTypeForFilelist < ActiveRecord::Migration
  def change
    change_column :caches, :filelist, :text
  end
end
