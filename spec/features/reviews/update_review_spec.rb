
feature "user updates review" do
  let!(:product) { FactoryGirl.create(:product_with_comments, comments_count: 1) }
  let!(:comment) { product.comments.first }
  # The :product_with_comments factory instantiates it's own User for an associated comment that must be referenced
  let!(:user) { User.find(comment.user_id) }

  # As a user
  # I want to edit a review
  # So that I can correct any mistakes or add updates
  #
  # Acceptance Criteria:
  # * I must provide valid information
  # * I must be presented with errors if I fill out the form incorrectly
  # * I must be able to get to the edit page from the product details page

  context "user is authenticated" do
    before(:each) do
      sign_in(user)
      visit products_path
      click_link "#{product.name}"
      click_link "Edit Review"
    end

    scenario "user can reach the edit page from details page" do
      expect(page).to have_current_path(edit_comment_path(comment))
    end

    scenario "user correctly edits review" do
      fill_in 'Description', with: "super awesome product!!"
      click_button 'Review Item'
      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content("Your review has been updated!")
      expect(page).to have_content("super awesome product!!")
    end

    scenario "user incorrectly fills out edit form" do
      fill_in 'Description', with: ""
      click_button 'Review Item'
      expect(page).to have_content("Description can't be blank and Description is too short (minimum is 10 characters)")
    end
  end

  context "user is not authenticated" do
    scenario "user cannot view reviews" do
      sign_out(user)
      visit edit_comment_path(comment)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
