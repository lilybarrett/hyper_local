require 'rails_helper'

feature 'user creates an account' do

  before :each do
    visit new_user_registration_path
  end

  scenario "user specifies valid and required info as a volunteer" do
    user = FactoryGirl.create(:user)
    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    select 'Volunteer', from: "Are you a volunteer or an organization?"
    attach_file "Profile Photo",
     "#{Rails.root}/spec/support/images/Launcher.jpg"

    click_button "Sign Up"

    expect(page).to have_content("Sign Out")
    expect(page).to have_css("img[src*='Launcher.jpg']")
  end

  scenario "user does not provide required information" do
    click_button "Sign Up"
    expect(page).to have_content("can't be blank")
  end

  scenario "password does not match confirmation" do
    user = FactoryGirl.create(:user)

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: "123456"

    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end

end
