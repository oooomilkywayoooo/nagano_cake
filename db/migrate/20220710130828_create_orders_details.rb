class CreateOrdersDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :orders_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :tax_price, null: false
      t.integer :amount, null: false
      #{0:製作不可 1:製作待ち 2:製作中 3:製作完了}
      t.integer :making_status, null: false, default: 0

      t.timestamps
    end
  end
end
