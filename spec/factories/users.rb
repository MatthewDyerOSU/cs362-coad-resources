FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 7, max_length: 128, mix_case: true) }
      confirmed_at { Time.now }
      role { :organization }
      association :organization, factory: :organization, optional: true
  
      trait :admin do
        role { :admin }
      end
    end
  end
  
