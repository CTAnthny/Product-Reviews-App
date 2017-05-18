
feature "user updates an item" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:product) { FactoryGirl.create(:product) }
  after(:all) { Product.delete_all; User.delete_all }

  # As an authenticated user
  # I want to update an item's information
  # So that I can correct errors or provide new information
  #
  # # Acceptance Criteria:
  # * I must be logged in and authorized to edit items
  # * I must provide valid information
  # * I am presented with errors if I fill out the form incorrectly
  # * I can reach the edit page from the details page
  # * After editing I am notified and returned to the show page

  context "user is authenticated" do
    before(:each) do
      sign_in(user)
      visit products_path
      click_link "#{product.name}"
      click_link "Edit Item"
    end

    scenario "user is logged in and authorized to edit items"

    scenario "user can reach the edit page from details" do
      expect(page).to have_current_path(edit_product_path(product))
    end

    scenario "user provides valid information and is returned to the show page" do
      fill_in 'Name', with: 'tennis racket'
      fill_in 'Description', with: 'hit tennis balls with this'
      fill_in 'Website', with: 'ebay.com'
      click_button "Submit"
      expect(page).to have_content("Your product has been successfully updated!")
      expect(page).to have_current_path(product_path(product))
    end

    scenario "user is presented with errors for invalid information" do
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      click_button "Submit"
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Name is too short")
      expect(page).to have_content("Description can't be blank")
      expect(page). to have_current_path(product_path(product))
    end
  end

  context "user is not authenticated" do
    scenario "user cannot view items" do
      sign_out(user)
      visit products_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to_not have_content('MyString 1')
      expect(page).to_not have_content('John Smith')
    end
  end
end
