require 'rails_helper'

feature 'user can create an account' do

  before :each do
    visit root_path
    click_link "Sign Up"
  end

  scenario "user specifies valid and required info" do

    # attach_file "Profile Photo", "#(Rails.root)/spec/support/images/soldier.jpg"
    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "Password"
    fill_in "Password Confirmation", with: "Password"

    click_button "Sign Up"

    expect(page).to have_content("Welcome!")
    expect(page).to have_content("Sign Out")
    # expect(page).to have_css("img[src*='soldier.jpg']")
  end

  # scenario "user uploads non-image file" do
  #
  # end

  scenario "user does not provide required information"
    click_button "Sign Up"
    expect(page).to have_content("can't be blank")
  end

  scenario "password does not match confirmation" do
    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "Password"
    fill_in "Password Confirmation", with: "123456"

    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end

end
