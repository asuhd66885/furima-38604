FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/サンプル画像.png'), filename: 'サンプル画像.png')
    end
    name { Faker::Lorem.sentence }
    info { Faker::Lorem.sentence }
    association :user
    category_id { 2 }
    sales_status_id { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 5000 }
  end
end
