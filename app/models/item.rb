class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def with_tax_price
    (price * 1.1).floor
  end
end
