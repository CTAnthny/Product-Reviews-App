
feature "user deletes account" do

  # As an authenticated user
  # I want to delete my account
  # So that my information is no longer retained by the app

  # Acceptance Criteria:
  # * User must be authenticated to delete account, and afterwards their
  #     information is no longer retained
  # * After deleting user account the user cannot re-sign in
  # * User must register again to gain access

  scenario "user must be authenticated to delete account" do
    visit root_path
    expect(page).to_not have_content('Cancel my account')
  end

  scenario "an unauthenticated user is redirected from the delete url" do
    visit cancel_user_registration_path
    expect(page).to have_content('Sign Up')
    expect(page).to_not have_content('Cancel my account')
  end

  scenario "user deletes account and cannot re-sign in" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link('Edit Account')
    click_link('Cancel my account')

    expect(page).to have_content('Your account has been successfully cancelled. We hope to see you again soon.')
    expect(page).to_not have_content('Sign Out')

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or Password.')
  end
end
