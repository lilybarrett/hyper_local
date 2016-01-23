require 'rails_helper'

feature "user edits an opportunity for an organization" do

  let!(:user) { FactoryGirl.create(:user, volunteer: false) }
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:org_admin) { FactoryGirl.create(
    :org_admin,
    user: user,
    organization: organization) }
  let!(:opportunity) { FactoryGirl.create(:opportunity) }

  scenario "an authenticated org_admin successfully edits an opportunity" do
    sign_in(user)
    visit edit_opportunity_path(opportunity)

    fill_in "Capacity", with: 6

    click_on "Update"

    expect(page).to have_content
      "Description: Lead an HTML/CSS workshop for middle school girls"
  end

  scenario "an authenticated org_admin unsuccessfully edits an opportunity" do
    sign_in(user)
    visit edit_opportunity_path(opportunity)

    fill_in "Capacity", with: " "

    click_on "Update"

    expect(page).to have_content "Please fill out all required fields."
  end

  scenario "an unauthenticated org_admin cannot edit an opportunity" do
    visit organization_path(organization)

    expect(page).not_to have_content("Change Opportunity Info")
  end

  scenario "an authenticated org_admin cannot edit an opportunity for an
    organization other than his or her own" do
    user_2 = FactoryGirl.create(:user, volunteer: false)
    sign_in(user_2)

    visit organization_path(organization)
    expect(page).not_to have_content("Change Opportunity Info")
  end

  scenario "an authenticated volunteer cannot edit an opportunity for an
    organization" do
    user_3 = FactoryGirl.create(:user, volunteer: true)
    sign_in(user_3)

    visit organization_path(organization)
    expect(page).not_to have_content("Change Opportunity Info")
  end
end
