FactoryBot.define do
  factory :inventory do
    sequence(:ingredient) { |n| "Ingredient #{n}" }
    quantity { 100 }
  end

  factory :dough_inventory, class: Inventory do
    ingredient { "Dough" }
    quantity { 200 }
  end

  factory :cheese_inventory, class: Inventory do
    ingredient { "Cheese" }
    quantity { 100 }
  end
end
