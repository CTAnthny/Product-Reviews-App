
feature "user views all reviews" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:product) { FactoryGirl.create(:product_with_comments) }
  let(:first_comment) { product.comments.first }
  let(:last_comment) { product.comments.last }

  # As a user
  # I want to view the reviews for the product
  # So that I can learn more about the product
  #
  # Acceptance Criteria:
  # * I must be on the product detail page
  # * I must only see reviews to the product I'm viewing
  # * I must see all reviews listed in order, most recent first

  context "user is authenticated" do
    before(:each) do
      sign_in(user)
      visit products_path
      click_link "#{product.name}"
    end

    scenario "user visits product page and views all reviews" do
      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content("#{first_comment.description}")
      expect(page).to have_content("#{last_comment.description}")
    end

    scenario "reviews are listed in correct order" do
      content = first('div.reviews div span.crtd_at').text
      expect(content).to eq(last_comment.created_at.to_s)
    end
  end

  context "user is not authenticated" do
    scenario "user cannot view reviews" do
      sign_out(user)
      visit product_path(product)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
