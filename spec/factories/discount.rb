FactoryBot.define do
  factory :random_discount, class: Discount do
    percent_off       { rand(2..25) }
    requirement       { rand(10..50) }
    association       :merchant, factory: :random_merchant
  end
end
