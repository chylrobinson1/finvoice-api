FactoryBot.define do
  factory :invoice do
    sequence(:number) { |n| "INV#{n}" }
    amount { 500 }
    due_date { Date.today + 30.days }
    status { :created }
    borrower
  end
end