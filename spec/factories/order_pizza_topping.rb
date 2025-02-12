FactoryBot.define do
  factory :order_pizza_topping do
    association :order_pizza
    association :topping
  end
end
