class Inventory < ApplicationRecord
  validates :ingredient, :quantity, presence: true
end
