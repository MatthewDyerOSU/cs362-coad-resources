counter = 0
FactoryBot.define do
  factory :resource_category do
    name do
      counter += 1
      "#{Faker::Lorem.word}#{counter}"
    end
    active { true }
  end
end
