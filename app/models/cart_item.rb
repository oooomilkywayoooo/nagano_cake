class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_one_attached :image

  def sum_of_price
    item.add_tax_price * amount
  end
end
