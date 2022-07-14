class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  attachment :thumbnail
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
end