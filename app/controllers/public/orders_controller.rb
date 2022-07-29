class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
    @name = current_customer.last_name + current_customer.first_name
    @address = current_customer.postal_code + '　' + current_customer.address
  end

  def create
    @customer = current_customer
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
  end

  def show
  end

  def info
  end

  def thanks
  end

  def order_params
    params.require(:order).permit(:ship_address, :payment_method, :address_id, :postal_code, :address, :name)
  end
end
