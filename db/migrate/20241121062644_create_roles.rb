class CreateRoles < ActiveRecord::Migration[8.0]
  unless table_exists?(:roles)
    create_table :roles, id: :uuid do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :roles, :deleted_at
  end
end
