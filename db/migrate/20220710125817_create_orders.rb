class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :ship_postalcode, null: false
      t.string :ship_address, null: false
      t.string :ship_name, null: false
      
      #{0:入金待ち 1:入金確認 2:製作中 3:発送準備中 4:発送済み}
      t.integer :order_status, null: false, default: 0 
      
      #{0:クレジットカード 1:銀行振込}
      t.integer :payment_method, null: false, default: 0
      t.integer :amount_billed, null: false
      t.integer :shipping_fee, null: false

      t.timestamps
    end
  end
end
