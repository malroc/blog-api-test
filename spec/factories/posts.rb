FactoryBot.define do
  factory :post do
    body { FFaker::Lorem.sentence }
  end
end
