class Admin::OrdersDetailsController < ApplicationController

  def update
    @orders_detail = OrdersDetail.find(params[:id])
	  if @orders_detail.update(orders_detail_params)
	    flash[:success] = "注文ステータスを変更しました"
	    redirect_to admin_order_path(@orders_detail)
	  else
	    render "show"
	  end
  end

	private

	def orders_detail_params
	  params.permit(:making_status)
	end
end