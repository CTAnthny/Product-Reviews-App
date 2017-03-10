require 'spec_helper'

feature "user creates account" do
  # As a prospective user
  # I want to create an account
  # So that I can post items and review them

  # Acceptance Criteria:
  # * I must specify a valid email address
  # * I must specify a password and confirm that password
  # * If I do not perform the above, I get an error message
  # * If I specify valid information, I register my account and am authenticated

  scenario "specifying valid and required information" do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Success!")
    expect(page).to have_content("Sign Out")
  end

  scenario "required information is not supplied"

  scenario "password confirmation does not match"
end
