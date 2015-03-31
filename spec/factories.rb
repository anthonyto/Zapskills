#root/spec/factories.rb

FactoryGirl.define do
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
