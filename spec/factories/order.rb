FactoryBot.define do
  factory :order do
    association :order_pizzas, factory: :order_pizza
    status { "pending" }
  end
end
