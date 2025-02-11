class Topping < ApplicationRecord
  validates :name, :category, :price, persence: :true
end
