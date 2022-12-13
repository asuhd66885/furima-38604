FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    city { '名古屋' }
    address { '瑞穂' }
    phone_number { 22_233_335_444 }
    prefecture_id { 2 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
