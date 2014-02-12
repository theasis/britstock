class CreateCaches < ActiveRecord::Migration
  def change
    create_table :caches do |t|
      t.string :lightbox_id
      t.string :filelist

      t.timestamps
    end
  end
end
