require 'rails_helper'

feature 'user signs out' do
  scenario "an existing user specifies valid email and password" do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Sign Out"
    expect(page).to have_content("Signed out successfully.")
    expect(page).to have_content("Sign In")
  end

end
