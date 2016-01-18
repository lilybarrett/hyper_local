feature "user deletes account" do

  scenario "successfully deletes account" do

    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Edit Account"
    click_button "Delete My Account"

    expect(page).to have_content(
      "Bye! Your account has been successfully cancelled."
    )

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password.")
    expect(page).to have_content("Sign Up")
    expect(page).to_not have_content("Welcome")
  end
end
