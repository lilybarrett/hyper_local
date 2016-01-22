require "rails_helper"

feature "user edits account" do

  scenario "user cannot access page without signing in" do
    visit edit_user_registration_path

    expect(page).to have_content("Sign In")
    expect(page).to_not have_content("Edit Account")
  end

  scenario "an existing user changes email and password" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Edit Account"
    visit edit_user_registration_path

  # attach_file 'Profile Photo',
  #   "#{Rails.root}/spec/support/images/soldier.jpg"
    fill_in "Email", with: "new_email@example.com"
    fill_in "Password", with: "newpassword"
    fill_in "Password Confirmation", with: "newpassword"
    fill_in "Current Password", with: user.password
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_content("Sign Out")
    # expect(page).to have_css("img[src*='soldier.jpg']")
  end

  scenario "an existing volunteer changes designation to organization" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Edit Account"
    select 'Organization', from: "Are you a volunteer or an organization?"
    fill_in "Current Password", with: user.password
    click_button "Update"
    expect(page).to have_content("Register Your Organization")
  end

  scenario "an exiting org_admin changes designation to volunteer" do
    user_2 = FactoryGirl.create(:user, volunteer: false)
    visit new_user_session_path
    fill_in "Email", with: user_2.email
    fill_in "Password", with: user_2.password
    click_button "Sign In"

    click_link "Edit Account"
    select 'Volunteer', from: "Are you a volunteer or an organization?"
    fill_in "Current Password", with: user_2.password
    click_button "Update"
    expect(page).to have_content("Start With Your City")
  end

  # scenario "user uploads non-image file" do
  #   sign_in(@user)
  #   click_link 'Edit Account'
  #
  #   attach_file 'Profile Photo', "#{Rails.root}/spec/support/images/text.txt"
  #   fill_in 'Current Password', with: @user.password
  #   click_button "Update"
  #
  #   expect(page).to have_content("allowed types: jpg, jpeg, gif, png, bmp")
  # end

  scenario "user does not provide required information" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link 'Edit Account'
    visit edit_user_registration_path

    click_button "Update"
    expect(page).to have_content("can't be blank")
  end

  scenario "new password and confirmation do not match" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Edit Account"
    visit edit_user_registration_path

    fill_in "Email", with: "new_email@example.com"
    fill_in "Password", with: "newpassword"
    fill_in "Password Confirmation", with: "new1password"
    fill_in "Current Password", with: user.password

    click_button "Update"
    expect(page).to have_content("doesn't match")
  end

  scenario "user supplies wrong current password" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Edit Account"
    visit edit_user_registration_path

    fill_in "Email", with: "new_email@example.com"
    fill_in "Password", with: "newpassword"
    fill_in "Password Confirmation", with: "newpassword"
    fill_in "Current Password", with: "newwwwwwpasswordddd"

    click_button "Update"
    expect(page).to have_content("Current password is invalid")
    expect(page).to have_content("Sign Out")
  end
end
