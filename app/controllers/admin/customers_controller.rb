class Admin::CustomersController < ApplicationController
  before_action :set_find_customer, only: [:show, :edit]

  def index
    @customers = Customer.all
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      flash[:notice] = "変更しました"
      redirect_to admin_customer_path(customer)
    else
      render :edit
    end
  end

  private

  def set_find_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
     params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end
end
