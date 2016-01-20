require 'rails_helper'

feature "User adds an organization" do

  scenario "an existing user specifies valid info for an organization" do
    user = FactoryGirl.create(:user, volunteer: false)
    organization = FactoryGirl.create(:organization)
    org_admin = FactoryGirl.create(
      :org_admin,
       user: user,
       organization: organization)
    another_cause = FactoryGirl.create(:cause, cause: "Technology and Privacy")

    visit new_user_registration_path

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    select 'Organization', from: "Are you a volunteer or an organization?"
    click_button "Sign Up"

    expect(page).to have_content("Register Your Organization")

    fill_in "Organization Name", with: organization.name
    fill_in "Street Address", with: organization.street
    fill_in "City", with: organization.city
    fill_in "Description", with: organization.description
    fill_in "State", with: organization.state
    select "Technology and Privacy", from: "What's Your Cause?"
    click_button "Register"

    expect(page).to have_content("success")
  end

  scenario "user does not provide required information" do
    user = FactoryGirl.create(:user, volunteer: false)
    organization = FactoryGirl.create(:organization)
    org_admin = FactoryGirl.create(
      :org_admin,
       user: user,
       organization: organization)

    visit new_user_registration_path
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
  end

end
