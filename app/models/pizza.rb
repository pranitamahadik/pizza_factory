class Pizza < ApplicationRecord
  has_many :order_pizzas
  validates :name, :category, :price_regular, :price_medium, :price_large, presence: true
  validates :name, uniqueness: true
end
