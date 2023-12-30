class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.references :follower, references: :users, foreign_key: { to_table: :users }
      t.references :followee, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :follows, [:follower_id, :followee_id], unique: true
  end
end
