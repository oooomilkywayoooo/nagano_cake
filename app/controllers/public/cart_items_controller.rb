class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @customer = current_customer
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_items = current_customer.cart_items.all
    @customer = current_customer
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to public_cart_items_path
    elsif @cart_item.save
      @cart_item = current_customer.cart_items.all
      render 'index'
    else
      render 'index'
    end

  end

  def update
  end

  def destroy
  end

  def all_destroy
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:image, :name, :amount, :price)
  end
end
