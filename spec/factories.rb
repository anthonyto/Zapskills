#root/spec/factories.rb

FactoryGirl.define do
  factory :skill do
    name "Cooking"
  end
  factory :experience do
    description "abcdfef"
    start_date "11/23/1989"
    level "4"
  end
  factory :user do
    first_name     "Michael"
    last_name      "Harlt"
    email    "michael@example.com"
    password "foobar123"
    password_confirmation "foobar123"
    city "Madison"
    state "WI"
    zip_code "53726"
    date_of_birth "23/11/1989"
    factory :user_with_experience do
      after(:create) do |user|
        create(:experience, user: user)
      end
    end
  end
end
