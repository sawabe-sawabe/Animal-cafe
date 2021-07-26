FactoryBot.define do
  factory :group do
    name { Faker::Lorem.characters(number: 5) }
    introduction { Faker::Lorem.characters(number: 20) }
    word { Faker::Lorem.characters(number: 15) }

  end
end
