FactoryBot.define do
  factory :author do
    fullname { Faker::Name.name }
  end
end