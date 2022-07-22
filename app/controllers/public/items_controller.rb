class Public::ItemsController < ApplicationController
  def index
    @customer = current_customer
  end
end
