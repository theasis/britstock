class CreatePhotographers < ActiveRecord::Migration
  def change
    create_table :photographers do |t|
      t.string :name
      t.text :description
      t.string :website
      t.string :phone
      t.string :email
      t.string :istock_name
      t.integer :istock_userid
      t.string :password
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
