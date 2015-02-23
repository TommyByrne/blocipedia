# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Gary"
    sequence(:email) { |n| "gary#{n}@example.com"}
    password "password"
    confirmation password "password"
  end
end
