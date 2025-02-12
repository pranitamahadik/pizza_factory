FactoryBot.define do
  factory :topping do
    sequence(:name) { |n| "Topping #{n}" }
    category { "veg" }
    price { 20 }

    trait :non_veg do
      category { "non-veg" }
      price { 35 }
    end

    trait :paneer do
      name { "Paneer" }
      category { "veg" }
      price { 35 }
    end

    trait :extra_cheese do
      name { "Extra Cheese" }
      category { "veg" }
      price { 35 }
    end
  end
end
