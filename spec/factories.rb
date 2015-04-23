#root/spec/factories.rb

FactoryGirl.define do
  factory :review do
    skill 
    stars "4"
    body "limit: 65535"
  end
  factory :skill do
    name "Cooking"
  end
  factory :experience do
    description "abcdfef"
    start_date "1989-11-23"
    level "4"
    skill
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
  end
end
