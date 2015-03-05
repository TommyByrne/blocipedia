FactoryGirl.define do
  factory :user do
    name "Gary"
    sequence(:email) { |n| "gary#{n}@example.com"}
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end
