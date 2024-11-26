class CreateUsers < ActiveRecord::Migration[8.0]
  unless table_exists?(:users)
    create_table :users, id: :uuid do |t|
      t.string :name, null: false, limit: 255 # Add constraints as needed
      t.uuid :role_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :users, :deleted_at
  end
end

