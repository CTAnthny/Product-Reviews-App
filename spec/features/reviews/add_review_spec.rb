
feature "user reviews item" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:product) { FactoryGirl.create(:product) }
  let!(:comment) { FactoryGirl.create(:comment) }

  # As an authenticated user
  # I want to add a review for an item
  #
  # Acceptance Criteria:
  # * I must be logged in to review an item
  # * I must be on the product detail page
  # * I must provide a review that is at least 50 characters long
  # * I must be presented with errors if I fill out the form incorrectly
  # * User is redirected to detail page and review shows the posting user

  context "user is authenticated" do
    before(:each) do
      sign_in(user)
      visit products_path
      click_link "#{product.name}"
    end

    scenario "user visits product detail page and successfully reviews item" do
      fill_in "Description", with: "#{comment.description}"
      click_button "Review Item"

      expect(page).to have_content("Your review was successfully posted!")
      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content("John Smith")
    end

    scenario "user submits invalid information" do
      fill_in "Description", with: ""
      click_button "Review Item"
      expect(page).to_not have_content("Your review was successfully posted!")
      expect(page).to have_content("Description can't be blank.")
    end
  end

  context "user is not authenticated" do
    scenario "user cannot add a review" do
      sign_out(user)
      visit product_path(product)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
