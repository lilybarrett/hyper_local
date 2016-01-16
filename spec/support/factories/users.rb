require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name "Jon"
    last_name "Smith"
    password "Password"
    password_confirmation "Password"
    volunteer true
  end
end
