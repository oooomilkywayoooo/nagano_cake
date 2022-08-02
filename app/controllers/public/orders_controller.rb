class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
    @address = Address.new
    @name = current_customer.last_name + current_customer.first_name
    @customer_address = current_customer.postal_code + '　' + current_customer.address
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
    end
  end

  def create
    @customer = current_customer
    @order = current_customer.orders.new(order_params)
    if @order.save
      flash[:notice] = "ご注文が確定しました"
      redirect_to thanks_public_orders_path
    end


    #select_address"2"の場合、配送先に追加
    #追加されない　質問する
    if params[:order][:select_address] == "2"
      @address = Address.new(address_params)
      @address.save
    end

    #カート商品の情報を商品詳細に移動
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @orders_details = @order.orders_details.new
        @orders_details.item_id = cart_item.item.id
        @orders_details.order_id = cart_item.customer_id
        @orders_details.tax_price = cart_item.item.add_tax_price
        @orders_details.amount = cart_item.amount
        @orders_details.save
          thanks_public_orders_path and return
      end
    #注文完了後、カート内商品を空にする
    @cart_items.destroy_all
  end

  def thanks
    @customer = current_customer
  end

  def index
    @customer = current_customer
    @orders = current_customer.orders
  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @orders_details = @order.orders_details
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :ship_postalcode, :ship_address, :ship_name, :amount_billed, :shipping_fee)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
