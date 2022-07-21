class Public::HomesController < ApplicationController
  def top
    @customer = current_customer
    @genres = Genre.all
    @items = Item.order('id DESC').limit(4)
  end

  def about
  end
end
