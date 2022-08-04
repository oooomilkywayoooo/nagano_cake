class Public::AddressesController < ApplicationController
  before_action :set_customer
  before_action :set_address, only: [:edit, :update, :destroy]
  before_action :set_addresses, only: [:index, :create]

  def index
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "新しい配送先を登録しました"
      redirect_to public_addresses_path
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      flash[:notice] = "変更しました"
      redirect_to public_addresses_path(@address)
    else
      render :index
    end
  end

  def destroy
    @address.destroy
    redirect_to public_addresses_path(@address)
  end

  private

  def set_customer
    @customer = current_customer
  end

  def set_address
    @address = Address.find(params[:id])
  end

  def set_addresses
    @addresses = Address.all
  end


  def address_params
     params.require(:address).permit(:postal_code, :address, :name, :customer_id).merge(customer_id:current_customer.id)
  end
end
