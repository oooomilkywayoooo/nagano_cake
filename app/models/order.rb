class Order < ApplicationRecord
  has_many :orders_details, dependent: :destroy
  belongs_to :customer

  validates :customer_id, :ship_address, :ship_name, :payment_mrthod, :amount_billed, presence: true
  validates :ship_postalcode, length: {is: 7}, numericality: {only_integer: true }

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1}
  enum order_status: {"入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4}
end
