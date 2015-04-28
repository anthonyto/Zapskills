require "rails_helper"

RSpec.describe "Signup process: ", :type => :feature do

  after :each do
    expect(page).to have_content 'SIGN UP Email Password (8 characters minimum) Password confirmation'
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully"
  end

  scenario "sign up from homepage" do
    visit ''
    click_link 'Sign Up'
  end

  scenario "sign up from url" do
    visit '/users/sign_up'
  end
 
  scenario "sign up from sign in page" do
    visit '/users/sign_in'
    click_link 'Sign Up'
  end
end
