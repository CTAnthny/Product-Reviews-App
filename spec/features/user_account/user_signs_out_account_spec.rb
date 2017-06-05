
feature "user signs out" do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  # As an authenticated user
  # I want to sign out
  # So that no one else can post items or reviews on my behalf

  # Acceptance Criteria:
  # * When I click the sign-out link I am signed out and my session is cleared

  scenario "user clicks sign-out link and session is cleared" do
    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
  end
end
