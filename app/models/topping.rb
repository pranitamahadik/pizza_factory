class Topping < ApplicationRecord
  validates :name, :category, :price, presence: true
  validates :name, uniqueness: true
end
