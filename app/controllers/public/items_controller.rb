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
    @cart_item = CartItem
  end

  private
  def item_params
    params.require(:items).permit(:genre_id, :name, :introduction, :image_id, :price)
  end
end
