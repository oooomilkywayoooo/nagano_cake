class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def show
  end

  def edit
    @genres = Genre.all
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "変更しました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
     params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
end


