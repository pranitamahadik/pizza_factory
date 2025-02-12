FactoryBot.define do
  factory :order_pizza do
    association :pizza
    association :crust
    size { "regular" }
    association :order

    trait :large do
      size { "large" }
    end
  end
end
