FactoryBot.define do
  factory :order_side do
    association :order
    association :side
  end
end
