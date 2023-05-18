class Address < ApplicationRecord
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  belongs_to :customer

end
