FactoryBot.define do
  factory :organization do
    sequence(:email) do |n|
      "#{n}#{Faker::Internet.email}"
    end
    sequence(:name) do |n|
      "#{Faker::Company.name}#{n}"
    end
    description { Faker::Lorem.sentence }
    phone { Faker::PhoneNumber.phone_number }
    primary_name { Faker::Name.name }
    secondary_name { Faker::Name.name }
    secondary_phone { Faker::PhoneNumber.phone_number }
    status { 1 }
  end
end
