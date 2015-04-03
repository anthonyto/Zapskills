require "rails_helper"

RSpec.describe "the signin_signup process", :type => :feature do

  it "signs me up from sign in" do
    visit ''
    click_link 'Sign up'
    expect(page).to have_content 'Sign up'
  end

  it "signs me up from url" do
    visit '/users/sign_up'
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
      fill_in "Password confirmation", :with => "password"
    end
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully"    
  end
end
