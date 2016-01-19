require 'rails_helper'

feature 'user signs in' do

  before :each do
    visit new_user_session_path
    click_link "Sign In"
  end

  scenario "an existing user specifies valid email and password" do
    user = FactoryGirl.create(:user)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign In"
    expect(page).to have_content("Sign Out")
  end

  scenario "user supplies nonexistent email and password" do

    fill_in "Email", with: "abc@xyz.com"
    fill_in "Password", with: "plasshhwordd"
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password.")
    expect(page).to have_content("Sign Up")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "user supplies existing email with wrong password" do
    user = FactoryGirl.create(:user)
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpw"
    click_button 'Sign In'

    expect(page).to have_content("Invalid")
    expect(page).to have_content("Sign Up")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an already authenticated user cannot sign in again" do
    user = FactoryGirl.create(:user)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")

    visit new_user_session_path

    expect(page).to have_content("already signed in")
    expect(page).to_not have_content("Sign In")
  end

end
