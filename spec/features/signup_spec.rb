require "rails_helper"

RSpec.describe "Signup process: ", :type => :feature do

  before :each do
    sleep(1)
  end

  after :each do
    expect(page).to have_content 'Sign Up Email Password Password confirmation'
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully"
  end

  scenario "sign up from homepage" do
    visit ''
    click_link 'Get Started Today!'
  end

  scenario "sign up from url" do
    visit '/users/sign_up'
  end
 
  scenario "sign up from sign in page" do
    visit '/users/sign_in'
    click_link 'Not yet a member? Sign up here.'
  end
end
