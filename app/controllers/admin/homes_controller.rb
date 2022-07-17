class Admin::HomesController < ApplicationController
  def top
    @orders_details = OrdersDetail.all
  end
end
