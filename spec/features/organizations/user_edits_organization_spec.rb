require 'rails_helper'

feature "org_admin updates organization" do

  let!(:user) { FactoryGirl.create(:user, volunteer: false) }
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:org_admin) { FactoryGirl.create(
    :org_admin,
    user: user,
    organization: organization) }
  let!(:another_cause) { FactoryGirl.create(:cause, cause: "Technology and Privacy") }

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

   scenario "org_admin unsuccessfully fills out update form" do
     sign_in(user)

     visit organization_path(organization)
     click_on "Edit Info"

     fill_in "Street Address", with: " "
     click_on "Update"

     expect(page).not_to have_content("successfully updated")
   end

   scenario "unauthenticated org_admin cannot edit entry" do
     visit organization_path(organization)

     expect(page).not_to have_content("Edit Info")
   end

   scenario "authenticated org_admin cannot edit entry created by
     another org_admin" do
     user_2 = FactoryGirl.create(:user, volunteer: false)
     sign_in(user_2)

     visit organization_path(organization)
     expect(page).not_to have_content("Edit Info")
   end

   scenario "authenticated volunteer cannot edit entry created by
     an org_admin" do
     user_3 = FactoryGirl.create(:user, volunteer: true)
     sign_in(user_3)

     visit organization_path(organization)
     expect(page).not_to have_content("Edit Info")
   end
end
