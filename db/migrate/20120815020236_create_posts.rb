class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :type
      t.string :file
      t.boolean :active

      t.timestamps
    end
  end
end
