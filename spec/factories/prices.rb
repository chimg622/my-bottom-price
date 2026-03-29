FactoryBot.define do
  factory :price do
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }
    quantity              { Faker::Number.between(from: 1, to: 9_999) }
    unit                  { %w[gram ml piece].sample }
    unit_price            { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user
    association :shop
    association :item
  end
end
