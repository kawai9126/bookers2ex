class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.string :book_id
      t.integer :favorite_id
      t.integer :post_comment_id
      t.string :action
      t.boolean :checked, default: false, null: false


      t.timestamps
    end
    add_index :notifications, :visiter_id
    add_index :notifications, :visited_id
    add_index :notifications, :favorite_id
    add_index :notifications, :post_comment_id
  end
end
