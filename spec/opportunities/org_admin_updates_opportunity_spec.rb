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
    visit opportunity_path(opportunity)
    click_on "Change Opportunity Info"

    fill_in "Capacity", with: 6

    click_on "Add to Site"

    expect(page).to have_content
      "Description: Lead an HTML/CSS workshop for middle school girls"
  end

  scenario "an authenticated org_admin unsuccessfully edits an opportunity" do
    sign_in(user)
    visit opportunity_path(opportunity)
    click_on "Change Opportunity Info"

    fill_in "Capacity", with: " "

    click_on "Add to Site"

    expect(page).to have_content "Please fill out all required fields."
  end

  scenario "an unauthenticated org_admin cannot edit an opportunity" do
    visit opportunity_path(opportunity)

    expect(page).not_to have_content("Change Opportunity Info")
  end

  scenario "an authenticated org_admin cannot edit an opportunity for an
    organization other than his or her own" do
    user_2 = FactoryGirl.create(:user, volunteer: false)
    sign_in(user_2)

    visit opportunity_path(opportunity)
    expect(page).not_to have_content("Change Opportunity Info")
  end

  scenario "an authenticated volunteer cannot edit an opportunity for an
    organization" do
    user_3 = FactoryGirl.create(:user, volunteer: true)
    sign_in(user_3)

    visit opportunity_path(opportunity)
    expect(page).not_to have_content("Change Opportunity Info")
  end
end
