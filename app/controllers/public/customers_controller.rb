class Public::CustomersController < ApplicationController
  before_action :set_find_customer, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "変更しました"
      redirect_to public_customer_path(@customer)
    else
      render :edit
    end
  end

  def quit
    @customer = current_customer
  end

  def out
    @customer = Customer.find(params[:customer_id])
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to '/'
  end

  private

  def set_find_customer
    @customer = Customer.find(params[:id])
  end


  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
