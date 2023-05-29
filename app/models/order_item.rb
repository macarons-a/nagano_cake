class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  enum making_status: {
    cannot_start: 0, #着手不可
    wating_for_making: 1, #製作待ち
    is_making: 2, #製作中
    completion: 3 #製作完了
  }
end
