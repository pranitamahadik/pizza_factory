FactoryBot.define do
  factory :crust do
    sequence(:name) { |n| "Crust #{n}" }
  end
end
