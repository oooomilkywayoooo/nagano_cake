class Item < ApplicationRecord
  attachment :thumbnail

  private
  def items_params
    params.require(:item).permit(:name, :thumbnail, :introduction, :price, :genre_id, :is_active)
  end
end
