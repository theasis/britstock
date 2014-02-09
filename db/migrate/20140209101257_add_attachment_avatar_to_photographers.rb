class AddAttachmentAvatarToPhotographers < ActiveRecord::Migration
  def self.up
    change_table :photographers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :photographers, :avatar
  end
end
