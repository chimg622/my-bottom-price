FactoryBot.define do
  factory :shop do
    name                  { Faker::Company.name.slice(0, 30) }
    address               { Faker::Address.full_address }

    association :user
  end
end
