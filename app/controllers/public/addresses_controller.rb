class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.
    @customer = current_customer
  end
end
