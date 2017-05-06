# Seed products
if Rails.env.development?

  User.where(email: "seeder1@example.com").first_or_create!(first_name: "Jane", last_name: "Doe", password: "password")

  25.times do |n|
    name = Faker::Commerce.product_name + " #{n}"
    description = Faker::Hipster.sentence
    website = Faker::Internet.domain_name
    Product.create!(name: name, description: description, website: website)
  end
end
