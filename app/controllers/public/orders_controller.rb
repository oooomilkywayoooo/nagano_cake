class Public::OrdersController < ApplicationController
  def new
  end

  def create
  end

  def index
    @orders = Order.all
    @customer = current_customer
  end

  def show
  end

  def info
  end

  def thanks
  end
end
