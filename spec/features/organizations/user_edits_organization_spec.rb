require 'rails_helper'

feature "org_admin updates organization" do

  let!(:user) { FactoryGirl.create(:user, volunteer: false) }
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:org_admin) { FactoryGirl.create(
    :org_admin,
    user: user,
    organization: organization) }

  scenario "org_admin visits update page for organization" do

    sign_in(user)
    visit organization_path(organization)
    click_link "Edit Info"
    expect(page).to have_content("Edit Organization Info")

  end

  scenario "org_admin successfully fills out update form" do
    sign_in(user)

    visit organization_path(organization)
    click_on "Edit Info"

    fill_in "Street Address", with: "Another Street"

    click_on "Update"

    expect(page).to have_content "Another Street"
    expect(page).to have_content "successfully updated"

  end
  #
  # scenario "org_admin unsuccessfully fills out update form" do
  #   user = FactoryGirl.create(:user, volunteer: false)
  #   organization = FactoryGirl.create(:organization)
  #   org_admin = FactoryGirl.create(
  #     :org_admin,
  #     user: user,
  #     organization: organization)
  #   another_cause = FactoryGirl.create(:cause, cause: "Technology and Privacy")
  # end
  #
  # scenario "unauthenticated org_admin cannot edit entry" do
  #   user = FactoryGirl.create(:user, volunteer: false)
  #   organization = FactoryGirl.create(:organization)
  #   org_admin = FactoryGirl.create(
  #     :org_admin,
  #     user: user,
  #     organization: organization)
  #   another_cause = FactoryGirl.create(:cause, cause: "Technology and Privacy")
  # end
  #
  # scenario "authenticated org_admin cannot edit entry created by
  #   another org_admin" do
  #   user = FactoryGirl.create(:user, volunteer: false)
  #   organization = FactoryGirl.create(:organization)
  #   org_admin = FactoryGirl.create(
  #     :org_admin,
  #     user: user,
  #     organization: organization)
  #   another_cause = FactoryGirl.create(:cause, cause: "Technology and Privacy")
  # end
  #
  # scenario "authenticated volunteer cannot edit entry created by
  #   an org_admin" do
  #   user = FactoryGirl.create(:user, volunteer: true)
  #   organization = FactoryGirl.create(:organization)
  #   visit new_user_registration_path
  #
  #   fill_in "First Name", with: user.first_name
  #   fill_in "Last Name", with: user.last_name
  #   fill_in "Email", with: "user@example.com"
  #   fill_in "Password", with: user.password
  #   fill_in "Password Confirmation", with: user.password
  #   select 'Volunteer', from: "Are you a volunteer or an organization?"
  #   click_button "Sign Up"
  #
  #   visit edit_organization_path(organization)
  #
  #   expect(page).to_not have_button "Update"
  # end
end
