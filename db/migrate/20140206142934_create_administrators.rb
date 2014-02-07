class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :name
      t.string :gplus
      t.string :role

      t.timestamps
    end
  end
end
