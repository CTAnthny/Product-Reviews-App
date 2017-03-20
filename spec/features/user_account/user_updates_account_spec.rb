
feature "user updates account" do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  # As an authenticated user
  # I want to update my information
  # So that I can keep my profile up to date

  # Acceptance Criteria:
  # * User updates account information
  # * User must be authenticated to update information
  # * An unauthenticated user is redirected when visiting the update url

  scenario "changes account information" do
    click_link 'Edit Account'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'nobody2@example.com'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'newpassword'
    fill_in 'Current Password', with: 'password'
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario "user's current password must be provided to authenticate changes" do
    click_link 'Edit Account'
    click_button 'Update'
    expect(page).to have_content("can't be blank")
  end

  scenario "an unauthenticated user cannot edit information" do
    click_link 'Sign Out'
    expect(page).to_not have_content('Edit Account')
  end

  scenario "an unauthenticated user is redirected when visiting the edit url" do
    click_link 'Sign Out'
    visit edit_user_registration_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
