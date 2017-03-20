
feature "user adds item" do
  let(:user) { FactoryGirl.create(:user) }

  # As an authenticated user
  # I want to add an item
  # So that others can review it

  # Acceptance Criteria:
  # * I must be logged in to add an item
  # * I must provide an item name and description
  # * I may optionally provide the item's website
  # * If I do not supply the required information, I receive an error message
  # * If an item with that name is already in the database, I receive an error

  context "user is authenticated" do
    scenario "user properly fills out the form and submits an item" do
      sign_in(user)
      visit root_path
      click_link('Add Item')
      fill_in 'Name', with: 'baseball'
      fill_in 'Description', with: 'you throw it'
      fill_in 'Website', with: 'ebay.com'
      click_button 'Submit'

      expect(page).to have_content('Your item has been successfully submitted!')
      expect(page).to have_content('you throw it')
    end

    scenario "user does not provide item name and description"

    scenario "if an item with that name already exists, user receives an error"
  end

  context "user is not authenticated" do
    scenario "user cannot add an item" do
      # have the user try to visit the new item page
      visit root_path
      expect(page).to_not have_content('Add Item')
      # expect them to saee a message saynig they're not allowed
    end
  end
end
