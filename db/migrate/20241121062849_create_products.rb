class CreateProducts < ActiveRecord::Migration[8.0]
  unless table_exists?(:products)
    create_table :products, id: :uuid do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :stock_quantity
      t.uuid :category_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :products, :deleted_at
  end
end
