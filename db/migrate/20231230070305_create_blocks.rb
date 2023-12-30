class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.references :blocker, references: :users, foreign_key: { to_table: :users }
      t.references :blocked, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :blocks, [:blocker_id, :blocked_id], unique: true
  end
end
