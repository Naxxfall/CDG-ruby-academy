FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name }
    email { FFaker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
  end
end