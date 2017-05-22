
feature "user views all items" do
  let(:user) { FactoryGirl.create(:user) }
  before(:all) { 25.times { FactoryGirl.create(:product) } }
  after(:all) { Product.delete_all; User.delete_all }

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
      sign_in(user)
      visit products_path
    end

    scenario "user views items with details" do
      expect(page).to have_content("#{Product.last.name}")
      expect(page).to have_content("#{Product.last.description}")
      expect(page).to have_content("#{Product.last.website}")
      expect(page).to have_content('John Smith')
    end

    scenario "user views item in correct order" do
      content = first('div.details span.upd_at').text
      last_upd_product = Product.last
      expect(content).to eq(last_upd_product.updated_at.to_s)
    end

    scenario "user is able to paginate items" do
      expect(page).to have_selector('ul.pagination')

      Product.page(2).each do |product|
        expect(page).to have_selector('div.product', text: product.name)
      end
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
