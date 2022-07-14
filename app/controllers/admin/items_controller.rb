class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)

    binding.pry

    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def item_params
     params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
end


