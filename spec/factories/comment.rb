FactoryBot.define do
  factory :comment do
    association :user
    association :post
    text { FFaker::Lorem.sentence }
    post_id { post.id }
  end
end