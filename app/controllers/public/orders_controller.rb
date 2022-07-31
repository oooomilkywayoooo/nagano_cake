class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
    @name = current_customer.last_name + current_customer.first_name
    @address = current_customer.postal_code + '　' + current_customer.address
  end

  def info
    @customer = current_customer
    @order = Order.new(order_params)
    @cart_items = CartItem.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @amount_billed = @total.to_i + 800
    if params[:order][:select_address] == "0"
      @order.ship_postalcode = current_customer.postal_code
      @order.ship_address = current_customer.address
      @order.ship_name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.ship_postalcode = @address.postal_code
      @order.ship_address = @address.address
      @order.ship_name = @address.name

    elsif params[:order][:select_address] == "2"
      @order.ship_postalcode = params[:order][:ship_postalcode]
      @order.ship_address = params[:order][:ship_address]
      @order.ship_name = params[:order][:ship_name]
      redirect_to public_orders_info_path
    end
  end

  def create
    @customer = current_customer
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "ご注文が確定しました"
      redirect_to thanks_public_orders_path
    end


    #select_address"2"の場合、配送先に追加
    if params[:order][:select_address] == "2"
      current_customer.address.create(address_params)
    end

    #カート商品の情報を商品詳細に移動
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
    OrdersDetail.create(
      item: cart_item.item,
      order: @order,
      amount: cart_item.amount,
      tax_price: sum_of_price(cart_item)
      )
    end
    #注文完了後、カート内商品を空にする
    @cart_items.destroy_all
  end

  def thanks
    @customer = current_customer
  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @orders_details = @order.orders_details
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :ship_postalcode, :ship_address, :ship_name, :amount_billed)
  end

  def address_params
    params.require(:order).permit(:postal_code, :saddress, :name)
  end
end
