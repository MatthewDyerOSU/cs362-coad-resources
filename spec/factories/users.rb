# counter = 0
# FactoryBot.define do
#     factory :user do
#         counter += 1
#         name "#{Faker::Lorem.word}#{counter}"
#         email { "#{Faker::Internet.email}" }
#         password "#{Faker::Internet.password}"
#     end
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
  
