class Side < ApplicationRecord
  validates :name, :price, presence: true
end
