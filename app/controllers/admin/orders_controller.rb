class Admin::OrdersController < ApplicationController
  def show
  	@order = Order.find(params[:id])
    @orders_details = @order.orders_details
    @total = @orders_details.inject(0) { |sum, item| sum + item.sum_of_price }
  end

	def update
	  @order = Order.find(params[:id])
	  if @order.update(order_params)
	    flash[:success] = "注文ステータスを変更しました"
	    redirect_to admin_order_path(@order)
	  else
	    render "show"
	  end
	end

	private

	def order_params
		  params.require(:order).permit(:order_status)
	end
end
