class Admin::HomesController < ApplicationController
  def top
    @orders_details = OrdersDetail.all.page(params[:page]).per(10)
  end
end
