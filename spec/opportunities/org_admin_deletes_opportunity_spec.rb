feature "org_admin deletes opportunity" do

  let!(:user) { FactoryGirl.create(:user, volunteer: false) }
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:org_admin) { FactoryGirl.create(
    :org_admin,
    user: user,
    organization: organization) }
  let!(:opportunity) { FactoryGirl.create(
    :opportunity,
    organization: organization) }

  scenario "successfully deletes opportunity" do

    sign_in(user)
    visit organization_path(organization)
    save_and_open_page
    click_on "Remove Opportunity"

    expect(page).to have_content organization.name
    expect(page).to_not have_content opportunity.description

    visit opportunities_path
    expect(page).to_not have_content opportunity.description
  end

  scenario "volunteer user cannot delete opportunity" do
    user_2 = FactoryGirl.create(:user, volunteer: true)

    sign_in(user_2)
    visit organization_path(organization)
    expect(page).to_not have_content "Remove Opportunity"
  end

  scenario "authenticated org_admin cannot delete opportunity for org other
  than his or her own" do
    user_3 = FactoryGirl.create(:user, volunteer: false)
    sign_in(user_3)

    visit organization_path(organization)
    expect(page).not_to have_content("Remove Opportunity")
  end

  scenario "an unauthenticated org_admin cannot delete an opportunity" do
    visit organization_path(organization)

    expect(page).not_to have_content("Remove Opportunity")
  end
end
