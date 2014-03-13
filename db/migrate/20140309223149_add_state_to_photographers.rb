class AddStateToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :state, :string, :default => "active"
  end
end
