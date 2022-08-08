class Order < ApplicationRecord
  has_many :orders_details, dependent: :destroy
  belongs_to :customer

  validates :customer_id, :ship_address, :ship_name, :payment_method, :amount_billed, presence: true

  enum payment_method: {"credit_card": 0, "transfer": 1}
  enum order_status: {"wait": 0, "check": 1, "making": 2, "preparation": 3, "done": 4}

  def shipping_fee
    800
  end

  def total_amount_billed
    @total + shipping_fee
  end

  def address_display
    '〒' + ship_postalcode + '　' + ship_address
  end
end
