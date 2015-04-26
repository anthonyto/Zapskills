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
  factory :user do |u|
    u.sequence(:first_name) { |n| "Michael#{n}"}
    u.last_name      "Harlt"
    u.sequence(:email) { |n|  "michael#{n}@example.com"}
    u.password "foobar123"
    u.password_confirmation "foobar123"
    u.city "Madison"
    u.state "WI"
    u.zip_code "53726"
    u.date_of_birth "23/11/1989"
  end

end
