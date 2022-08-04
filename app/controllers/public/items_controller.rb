class Public::ItemsController < ApplicationController
  before_action :set_customer
  before_action :set_genres

  def index
    @items = Item.all.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def set_customer
    @customer = current_customer
  end

  def set_genres
    @genres = Genre.all
  end

  def item_params
    params.require(:items).permit(:genre_id, :name, :introduction, :image_id, :price)
  end
end
