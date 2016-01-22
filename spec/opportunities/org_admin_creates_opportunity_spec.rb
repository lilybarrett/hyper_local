require 'rails_helper'

feature "user creates an opportunity for an organization" do

  let!(:user) { FactoryGirl.create(:user, volunteer: false) }
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:org_admin) { FactoryGirl.create(
    :org_admin,
    user: user,
    organization: organization) }

  scenario "an authenticated org_admin specifies valid info for an
    opportunity" do
    sign_in(user)
    visit organization_path(organization)
    click_on "Add Opportunity"

    fill_in "Description", with: "Lead an HTML/CSS workshop for middle school
      girls"
    fill_in "Capacity", with: 2
    fill_in "Street Address", with: "Awesome Street"
    fill_in "City", with: "Boston"
    fill_in "State", with: "MA"
    fill_in "Date", with: Date.today.to_s
    fill_in "Starts At:", with: "2:00 PM"
    fill_in "Ends At:", with: "4:00 PM"

    click_on "Add to Site"

    expect(page).to have_content "Description: Lead an HTML/CSS workshop for middle school girls"
  end

  scenario "an authenticated org_admin does not provide required information for an opportunity" do
    sign_in(user)
    visit organization_path(organization)
    click_on "Add Opportunity"

    fill_in "Description", with: "Lead an HTML/CSS workshop for middle school
      girls"
    fill_in "Capacity", with: "2"
    fill_in "Street Address", with: "Awesome Street"
    fill_in "City", with: " "
    fill_in "State", with: "MA"
    fill_in "Date", with: Date.today.to_s
    fill_in "Starts At:", with: "2:00 PM"
    fill_in "Ends At:", with: "4:00 PM"

    click_on "Add to Site"

    expect(page).to have_content "can't be blank"
    expect(page).not_to have_content "successfully added"
  end

  scenario "an unauthenticated org_admin cannot add an opportunity" do
    visit organization_path(organization)

    expect(page).not_to have_content("Add Opportunity")
  end

  scenario "an authenticated org_admin cannot add an opportunity for an
    organiztion other than his or her own" do
    user_2 = FactoryGirl.create(:user, volunteer: false)
    sign_in(user_2)

    visit organization_path(organization)
    expect(page).not_to have_content("Add Opportunity")
  end

  scenario "an authenticated volunteer cannot add an opportunity for an
    organization" do
    user_3 = FactoryGirl.create(:user, volunteer: true)
    sign_in(user_3)

    visit organization_path(organization)
    expect(page).not_to have_content("Add Opportunity")
  end

end
