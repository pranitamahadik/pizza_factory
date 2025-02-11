class OrderPizza < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  belongs_to :crust
  has_many :order_pizza_toppings, dependent: :destroy

  accepts_nested_attributes_for :order_pizza_toppings
  
  validates :size, inclusion: { in: %w[regular medium large] }
end
