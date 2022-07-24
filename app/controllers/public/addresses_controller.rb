class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
    @customer = current_customer
  end

  def create
    @customer = current_customer
    @addresses = Address.all
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "新しい配送先を登録しました"
      redirect_to public_addresses_path
    else
      render :index
    end
  end

  def edit
    @customer = current_customer
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "変更しました"
      redirect_to public_addresses_path(@address)
    else
      render :index
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path(@address)
  end

  private

  def address_params
     params.require(:address).permit(:postal_code, :address, :name, :customer_id).merge(customer_id:current_customer.id)
  end
end
