require 'valid_attribute'
require 'factory_girl_rails'
require_relative 'support/factories/factories'

require 'coveralls'
Coveralls.wear!('rails')

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password

  click_button "Sign In"
end
