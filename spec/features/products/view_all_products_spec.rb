
feature "user views all items" do
  let(:user) { FactoryGirl.create(:user) }

  # As an authenticated user
  # I want to view a list of items
  # So that I can pick items to review
  #
  # Acceptance Criteria:
  # * I must be logged in to view items
  # * I must be able to see the item name, description, website, create time, and user postee
  # * I must see items listed in order, most recently posted first
  # * I must be able to page view items

  context "user is authenticated" do
    before(:each) do
      visit root_path
      sign_in(user)
      visit products_path
    end

    scenario "user views items with details" do
      expect(page).to have_content('item name')
      expect(page).to have_content('description')
      expect(page).to have_content('website')
      expect(page).to have_content('create time')
      expect(page).to have_content('Jane Doe')

      expect(page).to have_content('another item name')
      expect(page).to have_content('another website')
    end

    scenario "user views item in correct order"
    scenario "user is able to paginate items"

  end

  context "user is not authenticated" do
    scenario "user cannot view items" do
      visit products_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to_not have_content('item name')
      expect(page).to_not have_content('Jane Doe')
    end
  end
end
