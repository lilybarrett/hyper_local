require 'rails_helper'

feature 'user creates an account' do

  before :each do
    visit root_path
    click_link "Sign Up"
  end

  scenario "user specifies valid and required info as a volunteer" do
    user = FactoryGirl.create(:user)
    # attach_file "Profile Photo",
      #"#(Rails.root)/spec/support/images/soldier.jpg"
    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    select 'Volunteer', from: "Are you a volunteer or an organization?"

    click_button "Sign Up"

    expect(page).to have_content("Welcome")
    expect(page).to have_content("Sign Out")
    # expect(page).to have_css("img[src*='soldier.jpg']")
  end

  # scenario "user uploads non-image file" do
  #
  # end

  # scenario "user specifies valid and required info as an organization" do
  #   org_user = FactoryGirl.create(:organization)
  #   # attach_file "Profile Photo",
        #"#(Rails.root)/spec/support/images/soldier.jpg"
  #   fill_in "First Name", with: org_user.first_name
  #   fill_in "Last Name", with: org_user.last_name
  #   fill_in "Email", with: org_user.email
  #   fill_in "Password", with: org_user.password
  #   fill_in "Password Confirmation", with: org_user.password
  #   select "Organization", from: "Are you a volunteer or an organization?"
  #   fill_in "Organization Name", with: org_user.org_name
  #   fill_in "Organization Description", with: org_user.description
  #   fill_in "Street Address", with: org_user.address
  #   fill_in "City", with: org_user.city
  #   select "MA", from: "State"
  #
  #   click_button "Sign Up"
  #
  #   expect(page).to have_content("Welcome!")
  #   expect(page).to have_content("Sign Out")
  #   # expect(page).to have_css("img[src*='soldier.jpg']")
  # end

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
