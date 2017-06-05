
feature "user deletes an item" do
  let!(:product) { FactoryGirl.create(:product_with_comments, comments_count: 1) }
  let!(:comment) { product.comments.first }
  # The :product_with_comments factory instantiates it's own User for an associated comment that must be referenced
  let!(:user) { User.find(comment.user_id) }

  # As an authenticated user
  # I want to delete an item
  # So that no one can review it
  #
  # # Acceptance Criteria:
  # * I must be logged in and authorized to delete items
  # * I must be able to delete a product from the edit page
  # * I must be able to delete a product from the details page
  # * All comments associated with the item must also be deleted
  # * After deleting I am notified and returned to the index page

  context "user is authenticated" do
    before(:each) do
      sign_in(user)
      visit products_path
      click_link "#{product.name}"
    end

    scenario "user is logged in and authorized to delete items"

    scenario "user is able to delete a product from the edit page" do
      click_link "Edit Item"
      click_link "Delete Item"
      expect(page).to have_content('Your item has been successfully deleted!')
    end

    scenario "user is able to delete a product from the show page" do
      click_link "Delete Item"
      expect(page).to have_content('Your item has been successfully deleted!')
    end

    scenario "after successful deletion the user is notified and directed to index" do
      click_link "Delete Item"
      expect(page).to have_content('Your item has been successfully deleted!')
      expect(page).to have_current_path(products_path)

      expect(page).to_not have_content("#{product.name}")
    end

    scenario "all comments associated with the item are deleted" do
      click_link "Delete Item"
      expect(product.comments).to eq([])
    end
  end

  context "user is not authenticated" do
    scenario "user cannot delete items"
  end
end
