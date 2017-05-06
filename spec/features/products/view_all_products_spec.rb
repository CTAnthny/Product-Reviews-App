
feature "user views all items" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before(:all) { 15.times { FactoryGirl.create(:user) } }
  after(:all) { User.delete_all }

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
      it { should have_content('item name') }
      it { should have_content('description') }
      it { should have_content('website') }
      it { should have_content('create time') }
      it { should have_content('Jane Doe') }

      it { should have_content('another item name') }
      it { should have_content('another website') }
    end

    scenario "user views item in correct order"
    scenario "user is able to paginate items" do
      
    end

  end

  context "user is not authenticated" do
    scenario "user cannot view items" do
      visit products_path
      it { should have_content('You need to sign in or sign up before continuing.') }
      it { should_not have_content('item name') }
      it { should_not have_content('Jane Doe') }
    end
  end
end
