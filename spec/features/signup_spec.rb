require "rails_helper"

RSpec.describe "the signin_signup process", :type => :feature do

  it "signs me up from sign in" do
    visit ''
    click_link 'Sign Up'
    expect(page).to have_content 'SIGN UP Email Password (8 characters minimum) Password confirmation'
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully"
  end

  it "signs me up from url" do
    visit '/users/sign_up'
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully"    
  end
end
