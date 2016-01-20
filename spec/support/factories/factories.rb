require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name "Jon"
    last_name "Smith"
    password "Password"
    password_confirmation "Password"
    volunteer true
  end

  factory :cause do
    cause "Test"
  end

  factory :organization do
    name "Girl Develop It"
    description "Girl Develop It is an organization that focuses on getting
    more women into the tech sector."
    street "Awesome St."
    city "Boston"
    state "MA"
    cause
  end

  factory :org_admin do
    user
    organization
  end
end
