FactoryBot.define do
  factory :post do
    association :user
    image_data { TestData.image_data }
    caption { FFaker::Lorem.sentence }
  end
end