class Admin::HomesController < ApplicationController
  def top
    @orders_details = OrdersDetail.all.page(params[:page]).per(10)
    @amount_count = OrdersDetail.count
  end
end
