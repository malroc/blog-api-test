FactoryBot.define do
  factory :post do
    body { FFaker::Lorem.paragraph }
  end
end
