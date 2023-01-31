FactoryBot.define do
  factory :ticket do
    name { Faker::Lorem.word }
    phone {
      "+1 (555) 555-#{Faker::PhoneNumber.subscriber_number}"
    }
    description { Faker::Lorem.sentence }
    region { FactoryBot.create(:region) }
    resource_category { FactoryBot.create(:resource_category) }
  end
end
