class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
    @name = current_customer.last_name + current_customer.first_name
    @address = current_customer.postal_code + '　' + current_customer.address
  end

  def create
    @customer = current_customer
  end

  def show
  end

  def info
  end

  def thanks
  end

end
