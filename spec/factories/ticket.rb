FactoryBot.define do
  factory :ticket do
    sequence(:name) do |n|
      "#{Faker::Lorem.word}#{n}"
    end
    sequence(:phone) do |n|
      "+1 (555) 555-#{n.to_s.rjust(4, '0')}"
    end
    description { Faker::Lorem.sentence }
    region { FactoryBot.build_stubbed(:region) }
    resource_category { FactoryBot.build_stubbed(:resource_category) }
  end
end
