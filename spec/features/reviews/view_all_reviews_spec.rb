
feature "user views all reviews" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:product_with_comments) { FactoryGirl.create(:product_with_comments) }

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
      click_link "#{product_with_comments.name}"
    end

    scenario "user visits product page and views all reviews" do
      expect(page).to have_current_path(product_path(product_with_comments))
      expect(page).to have_content("#{product_with_comments.comments.first.description}")
      expect(page).to have_content("#{product_with_comments.comments.last.description}")
    end

    scenario "reviews are listed in correct order" do
      content = first('div.reviews div span.crtd_at').text
      last_crtd_comment = product_with_comments.comments.last
      expect(content).to eq(last_crtd_comment.created_at.to_s)
    end
  end

  context "user is not authenticated" do
    scenario "user cannot view reviews" do
      sign_out(user)
      visit product_path(product_with_comments)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
