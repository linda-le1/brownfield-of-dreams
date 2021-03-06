FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    uid { nil }
    role { :default }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
