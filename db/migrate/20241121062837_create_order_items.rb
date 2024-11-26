class CreateOrderItems < ActiveRecord::Migration[8.0]
  unless table_exists?(:order_items)
    create_table :order_items, id: :uuid do |t|
      t.integer :quantity
      t.uuid :product_id
      t.uuid :order_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :order_items, :deleted_at
  end
end
