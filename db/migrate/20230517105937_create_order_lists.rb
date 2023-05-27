class CreateOrderLists < ActiveRecord::Migration[6.1]
  def change
    create_table :order_lists do |t|
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :amount, null: false
      t.integer :ordered_price, null: false

      t.timestamps null: false
    end
  end
end
