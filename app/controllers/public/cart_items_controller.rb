class Public::CartItemsController < ApplicationController
  def index
    @customer = current_customer
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_item = CartItem.new
    if @cart_item.save
      flash[:notice] = "カートに商品を入れました"
      redirect_to public_cart_items_path
    else
      render public_item_path(item)
    end
  end

  def update
  end

  def destroy
  end

  def all_destroy
  end
end
