counter = 0
FactoryBot.define do
  factory :region do
    name do
      counter += 1
      "#{Faker::Lorem.word}#{counter}"
    end
  end
end
