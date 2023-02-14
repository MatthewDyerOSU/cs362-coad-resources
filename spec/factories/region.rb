counter = 0
FactoryBot.define do
  factory :region do
    sequence :name do |n|
      "#{Faker::Lorem.word}#{n}"
    end
  end
end
