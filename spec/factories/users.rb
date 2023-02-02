counter = 0
FactoryBot.define do
  factory :user do
      counter += 1
      email { "#{counter}#{Faker::Internet.email}" }
      password { Faker::Internet.password }
  end
end
