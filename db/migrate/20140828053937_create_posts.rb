class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :description
      t.string :image
      t.string :title
      t.timestamps
    end
  end
end
