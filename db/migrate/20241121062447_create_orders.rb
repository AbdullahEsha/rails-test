class CreateOrders < ActiveRecord::Migration[8.0]
  unless table_exists?(:orders)
    create_table :orders, id: :uuid do |t|
      t.datetime :order_date
      t.string :status
      t.uuid :user_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :orders, :deleted_at
  end
end
