class CreateLightboxes < ActiveRecord::Migration
  def change
    create_table :lightboxes do |t|
      t.belongs_to :photographer, index: true
      t.integer :istockid

      t.timestamps
    end
  end
end
