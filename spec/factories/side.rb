FactoryBot.define do
  factory :side do
    sequence(:name) { |n| "Side #{n}" }
    price { 55 }
  end
end
