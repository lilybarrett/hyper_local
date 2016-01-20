require 'rails_helper'

feature "user updates organization" do

  scenario "user visits update page for organization" do
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

    visit edit_organization_path(organization)
    click_on "Edit Info"

    expect(page).to have_button "Update"
  end

  scenario "authenticated user successfully fills out update form" do
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

    click_on "Edit Info"

    expect(page).to have_button "Update"

    fill_in "Street Address", with: "Another Street"
    click_button "Update"

    expect(page).to have_content "Another Street"
  end

  scenario "user unsuccessfully fills out update form" do
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

    click_on "Edit Info"

    expect(page).to have_button "Update"

    fill_in "Street Address", with: " "
    click_button "Update"

    expect(page).to have_content "required fields"
  end

  scenario "unauthenticated user is unable to edit organization" do
    user = FactoryGirl.create(:user, volunteer: false)
    organization = FactoryGirl.create(:organization)
    org_admin = FactoryGirl.create(
      :org_admin,
      user: user,
      organization: organization)
    visit organization_path(organization)

    expect(page).to_not have_link "Edit Info"
  end

  scenario "authenticated organization cannot edit entry created by
    another organization" do
    user = FactoryGirl.create(:user, volunteer: false)
    user_2 = FactoryGirl.create(:user, volunteer: false)
    organization = FactoryGirl.create(:organization)
    org_admin = FactoryGirl.create(
      :org_admin,
      user: user,
      organization: organization)
    yet_another_cause = FactoryGirl.create(:cause, cause: "Healthcare Access")
    organization_2 = FactoryGirl.create(:organization, name: "Another Org", cause: yet_another_cause)
    org_admin_2 = FactoryGirl.create(
      :org_admin,
      user: user_2,
      organization: organization_2)
      another_cause = FactoryGirl.create(:cause, cause: "Technology and Privacy")
    visit new_user_registration_path

    fill_in "First Name", with: user_2.first_name
    fill_in "Last Name", with: user_2.last_name
    fill_in "Email", with: "user2@example.com"
    fill_in "Password", with: user_2.password
    fill_in "Password Confirmation", with: user_2.password
    select 'Organization', from: "Are you a volunteer or an organization?"
    click_button "Sign Up"

    expect(page).to have_content("Register Your Organization")

    fill_in "Organization Name", with: organization_2.name
    fill_in "Street Address", with: organization_2.street
    fill_in "City", with: organization_2.city
    fill_in "Description", with: organization_2.description
    fill_in "State", with: organization_2.state
    select "Technology and Privacy", from: "What's Your Cause?"
    click_button "Register"

    expect(page).to have_content("success")
    visit organization_path(organization)

    expect(page).to_not have_button "Update"
  end

  scenario "authenticated volunteer cannot edit entry created by
    an organization" do
    user = FactoryGirl.create(:user, volunteer: true)
    organization = FactoryGirl.create(:organization)
    visit new_user_registration_path

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    select 'Volunteer', from: "Are you a volunteer or an organization?"
    click_button "Sign Up"

    visit edit_organization_path(organization)

    expect(page).to_not have_button "Update"
  end
end
