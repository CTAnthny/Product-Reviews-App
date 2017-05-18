FactoryGirl.define do
  factory :product do
    sequence(:name, 1) { |n| "MyString #{n}" }
    description "MyText"
    website "sample_host.com"
    user
    sequence(:updated_at) { |n| Time.now + n }
  end
end
