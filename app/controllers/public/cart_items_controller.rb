class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @customer = current_customer
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @customer = current_customer
    @genres = Genre.all
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to public_cart_items_path
    else
      @cart_item.save
      redirect_to public_cart_items_path
    end
  end

  def update
    @cart_item = current_customer.cart_items
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def all_destroy
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :price, :image)
  end
end
