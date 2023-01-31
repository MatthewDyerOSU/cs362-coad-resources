FactoryBot.define do
    factory :resource_category do
      name { Faker::Lorem.word }
      active { true }
    end
  end