class OrderPizzaTopping < ApplicationRecord
  belongs_to :order_pizza
  belongs_to :topping
end
