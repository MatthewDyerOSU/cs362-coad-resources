# counter = 0
# FactoryBot.define do
#     factory :user do
#         counter += 1
#         name "#{Faker::Lorem.word}#{counter}"
#         email { "#{Faker::Internet.email}" }
#         password "#{Faker::Internet.password}"
#     end