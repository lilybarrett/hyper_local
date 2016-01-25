feature "User searches for opportunities" do

  let!(:user) { FactoryGirl.create(:user, volunteer: false) }
  let!(:organization) { FactoryGirl.create(:organization, cause_id: 9) }
  let!(:org_admin) { FactoryGirl.create(
    :org_admin,
    user: user,
    organization: organization)
  }
  let!(:opportunity) { FactoryGirl.create(:opportunity) }
  # another_cause = FactoryGirl.create(:cause, cause: "Technology and Privacy")

  scenario "user enters city in search bar and gets search results" do
    visit "/"
    fill_in "city_query", with: opportunity.city
    click_on "Search"

    expect(page).to have_content "#{opportunity.description}"
    expect(page).to_not have_content "Sorry! No matches yet."
  end

  # scenario "user selects cause from drop-down and gets search results" do
  #   visit "/"
  #   save_and_open_page
  #   select "Technology and Privacy", from: "What are you passionate about?"
  #   click_on "Search"
  #
  #   expect(page).to have_content
  #     "Description: Lead an HTML/CSS workshop for middle school girls"
  #   expect(page).to_not have_content "Sorry! No matches yet."
  # end

  # scenario "user types in location, selects cause from drop-down, and gets
  # search results" do
  #   visit "/"
  #   fill_in "city_query", with: opportunity.city
  #   select "Technology and Privacy", from: :cause_query
  #   click_on "Search"
  #
  #   expect(page).to have_content "#{opportunity.organization.cause.cause}"
  #   expect(page).to_not have_content "Sorry! No matches yet."
  # end

  scenario "user searches for item that does not return any results" do
    visit "/"
    fill_in "city_query", with: "Fake City"
    click_on "Search"

    expect(page).to_not have_content "#{opportunity.description}"
    expect(page).to have_content "Sorry! No matches yet."
  end
end
