FactoryBot.define do
  factory :comment do
    post
    body { FFaker::Lorem.phrase }
  end
end
