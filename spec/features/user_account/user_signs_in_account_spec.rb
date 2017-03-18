
feature "user signs in" do
  before :each do
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
  end

  # As an unauthenticated user
  # I want to sign in
  # So that I can post items and review them

  # Acceptance Criteria:
  # * If I specify a valid, previously registered email and password,
  #    I am authenticated and I gain access to the system
  # * If I specify an invalid email and password, I remain unauthenticated
  # * If I am already signed in, I can't sign in again

  scenario "an existing user specifies a valid email and password" do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out')
  end

  scenario "a non-existent email and password is supplied" do
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
    expect(page).to have_content('Invalid Email or Password')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario "an existing email with the wrong password is denied access" do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'incorrectPassword'
    click_button 'Sign In'
    expect(page).to have_content('Invalid Email or Password')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario "an already authenticated user cannot re-sign in" do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path
    expect(page).to have_content('You are already signed in.')
  end
end
