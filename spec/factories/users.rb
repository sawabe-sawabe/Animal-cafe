FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
    having_pets{ Faker::Lorem.characters(number: 5) }
    favorite_animal{ Faker::Lorem.characters(number: 5) }
    word{ Faker::Lorem.characters(number: 15) }

    trait :user_with_groups do
      after(:build) do |user|  # after(:build)とした場合、createの場合もcallbackが走る
        user.groups << build(:group)
      end
    end
  end
end




