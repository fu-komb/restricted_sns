class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.text :text, null: false
      t.integer :reply_to_post_id, null: true

      t.timestamps
    end
  end
end
