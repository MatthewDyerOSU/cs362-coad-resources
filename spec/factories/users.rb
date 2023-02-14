FactoryBot.define do
  factory :user do
    sequence(:email) do |n|
      "#{n}#{Faker::Internet.email}"
    end
    password { Faker::Internet.password(min_length: 7, max_length: 128, mix_case: true) }
    confirmed_at { Time.now }
    role { :organization }
    association :organization, factory: :organization, optional: true

    trait :admin do
      role { :admin }
    end

    trait :approved_org do
      role { :organization }
      association :organization, factory: :organization, status: :approved
    end

    trait :unapproved_org do
      role { :organization }
      association :organization, factory: :organization, status: :submitted
    end
  end
end
