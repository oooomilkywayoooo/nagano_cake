class Public::ItemsController < ApplicationController
  def index
    @customer = current_customer
    @items = Item.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = current_customer
  end
end
