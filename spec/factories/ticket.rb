counter = 0
FactoryBot.define do
  factory :ticket do
    name do
      counter += 1
      "#{Faker::Lorem.word}#{counter}"
    end
    phone {
      "+1 (555) 555-#{Faker::PhoneNumber.subscriber_number}"
    }
    description { Faker::Lorem.sentence }
    region { FactoryBot.build_stubbed(:region) }
    resource_category { FactoryBot.build_stubbed(:resource_category) }
  end
end
