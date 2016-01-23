require 'rails_helper'

feature "user views upcoming opportunities on site" do

  let!(:user) { FactoryGirl.create(:user, volunteer: false) }
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:org_admin) { FactoryGirl.create(
    :org_admin,
    user: user,
    organization: organization) }
  let!(:opportunity) { FactoryGirl.create(:opportunity) }

  scenario "a user only sees upcoming opportunities" do
    opportunity_2 = FactoryGirl.create(:opportunity, date: Date.today.prev_day)
    visit opportunities_path

    expect(page).to_not have_content(opportunity_2.date)
    expect(page).to have_content(opportunity.date)
  end

#user can view opportunities on organization show page

  scenario "a user can view details on opportunity show page" do
    opportunity_2 = FactoryGirl.create(:opportunity, date: Date.today.prev_day)
    visit opportunities_path

    expect(page).to_not have_content(opportunity_2.date)
    expect(page).to have_content(opportunity.date)
  end

  scenario "a user can view more details on opportunity show page" do
    visit opportunity_path(opportunity)

    expect(page).to have_content(opportunity.description)
  end
end
