
feature "user views the details of an item" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:product) { FactoryGirl.create(:product) }
  after(:all) { Product.delete_all; User.delete_all }

  # As an authenticated user
  # I want to view the details about an item
  # So that I can get more information about it

  # Acceptance Criteria:
  # * I must be logged in to view items
  # * I must be able to get to this page from the products index
  # * I must be able to see the product name, description, updated_at time, and user postee
  # * I must be able to view the item rating and comments

  context "user is authenticated" do
    before(:each) do
      sign_in(user)
      visit products_path
    end

    scenario "user selects an item from the index to view" do
      click_link "#{product.name}"
      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content("#{product.name}")
      expect(page).to have_content("Description: #{product.description}")
      expect(page).to have_content("Website: #{product.website}")
      expect(page).to have_content("Posted By: John Smith")
      expect(page).to have_content("Last Updated At: #{product.updated_at}")
    end

    scenario "user views item rating and comments"
  end

  context "user is not authenticated" do
    scenario "user cannot view items" do
      sign_out(user)
      visit products_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
