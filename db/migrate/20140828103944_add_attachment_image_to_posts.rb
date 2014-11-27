class AddAttachmentImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :image
      t.string :image_fingerprint
    end
  end
  def self.down
    remove_attachment :posts , :image
    remove_column :posts, :image_fingerprint
  end
end
