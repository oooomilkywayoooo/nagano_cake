class Product < ApplicationRecord
  def add_tax_price
    (self.price * 1.10).round
  end
end
