counter = 0
FactoryBot.define do
  factory :resource_category do
    sequence(:name) do |n|
      "#{Faker::Lorem.word}#{n}"
    end
    active { true }
  end
end
