FactoryBot.define do
  factory :post do
    association :user
    image_data { TestData.image_data }
    #image { TestData.cached_image }
    caption { FFaker::Lorem.sentence }
  end
end