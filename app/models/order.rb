class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  validates :address, presence: true
  validates :postal_code, presence: true
  validates :name, presence: true
  validates :payment_method, presence: true


  enum payment_method: {
    credit_card: 0, #クレジットカード
    transfer: 1 #銀行振り込み
  }

  enum status: {
    waiting_for_payment: 0, #入金待ち
    payment_confirmation: 1, #入金確認
    is_making: 2, #製作中
    preparing_ship: 3, #発送準備中
    shipped: 4 #発送済み
  }

end
