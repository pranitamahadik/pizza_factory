class Order < ApplicationRecord
  has_many :order_pizzas, dependent: :destroy
  has_many :order_sides, dependent: :destroy

  accepts_nested_attributes_for :order_pizzas, :order_sides

  validates :status, inclusion: { in: %w[pending confirmed completed] }
end
