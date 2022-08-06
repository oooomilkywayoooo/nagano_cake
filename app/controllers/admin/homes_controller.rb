class Admin::HomesController < ApplicationController
  def top
    @orders_details = OrdersDetail.all
    @item = Item.find_by(id: params[:id])
    @items_count = OrdersDetail.where(item: @item).count
  end
end
