counter = 0
FactoryBot.define do
  factory :organization do
    counter += 1
    email { "#{Faker::Internet.email}" }
    name { "#{Faker::Company.name}#{counter}" }
    description { Faker::Lorem.sentence }
    phone { Faker::PhoneNumber.phone_number }
    primary_name { Faker::Name.name }
    secondary_name { Faker::Name.name }
    secondary_phone { Faker::PhoneNumber.phone_number }
    status { 1 }
  end
end
