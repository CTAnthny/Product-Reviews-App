
feature "user deletes review" do
  let!(:product) { FactoryGirl.create(:product_with_comments, comments_count: 1) }
  let!(:comment) { product.comments.first }
  # The :product_with_comments factory instantiates it's own User for an associated comment that must be referenced
  let!(:user) { User.find(comment.user_id) }

  # As an authenticated user
  # I want to delete a review
  #
  # Acceptance Criteria:
  # * I must be able delete a review from the review edit page
  # * I must be able delete a review from the product details page

  context "user is authenticated" do
    before(:each) do
      sign_in(user)
      visit products_path
      click_link "#{product.name}"
    end

    scenario "user deletes review from the review edit page" do
      click_link "Edit Review"
      click_link "Delete"
      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content("Your review has been successfully deleted!")
      expect(page).to_not have_content("#{comment.description}")
    end

    scenario "user deletes review from the product details page" do
      click_link "Delete Review"
      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content("Your review has been successfully deleted!")
      expect(page).to_not have_content("#{comment.description}")
    end
  end

  context "user is not authenticated" do
    scenario "user cannot delete reviews"
  end
end
