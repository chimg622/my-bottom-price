FactoryBot.define do
  factory :item do
    name            { Faker::Commerce.product_name.slice(0, 40) }
    unit            { %w[gram ml piece].sample }

    association :user
    association :category
  end
end
