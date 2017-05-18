
feature "user adds item" do
  let(:user) { FactoryGirl.create(:user) }
  after(:all) { Product.delete_all; User.delete_all }
  
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
    before(:each) do
      sign_in(user)
      visit root_path
      click_link('Add Item')
    end

    scenario "user properly fills out the form and submits an item" do
      fill_in 'Name', with: 'baseball'
      fill_in 'Description', with: 'you throw it'
      fill_in 'Website', with: 'ebay.com'
      click_button 'Submit'
      expect(page).to have_content('Your product has been successfully submitted!')
      expect(page).to have_content('you throw it')
    end

    scenario "user does not provide item name and description" do
      click_button 'Submit'
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    scenario "if an item with that name already exists, user receives an error" do
      fill_in 'Name', with: 'baseball'
      fill_in 'Description', with: 'you throw it'
      fill_in 'Website', with: 'ebay.com'
      click_button 'Submit'
      expect(page).to have_content('Your product has been successfully submitted!')
      expect(page).to have_content('you throw it')

      click_link 'Add Item'
      fill_in 'Name', with: 'baseball'
      fill_in 'Description', with: 'you throw it'
      fill_in 'Website', with: 'ebay.com'
      click_button 'Submit'
      expect(page).to have_content('Name has already been taken')
    end
  end

  context "user is not authenticated" do
    scenario "user cannot add an item" do
      visit root_path
      expect(page).to_not have_content('Add Item')
    end

    scenario "user cannot access new product url" do
      visit new_product_path
      expect(page).to_not have_content('Add Item')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
