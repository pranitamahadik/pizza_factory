FactoryBot.define do
  factory :pizza do
    sequence(:name) { |n| "Pizza #{n}" }
    category { "veg" }
    price_regular { 150 }
    price_medium  { 200 }
    price_large   { 325 }

    trait :non_veg do
      category { "non-veg" }
      price_regular { 190 }
      price_medium  { 325 }
      price_large   { 425 }
    end
  end
end
