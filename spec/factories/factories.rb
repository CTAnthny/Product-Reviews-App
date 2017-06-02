FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com"}
    first_name 'John'
    last_name 'Smith'
    password 'password'
  end

  factory :comment do
    sequence(:description) { |n| "#{n} Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged." }
    user
  end

  factory :product do
    sequence(:name, 1) { |n| "MyString #{n}" }
    description "MyText"
    website "sample_host.com"
    user
    sequence(:updated_at) { |n| Time.now + n }

    # Create a singular product with many comments using create_list (see FactoryGirl associations doc)
    factory :product_with_comments do
      transient do
        comments_count 3
      end

      after(:create) do |product, evaluator|
        create_list(:comment, evaluator.comments_count, product: product)
      end
    end
  end
end
