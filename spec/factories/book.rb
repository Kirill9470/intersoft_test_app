FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    author { Faker::Name.name }
  end
end