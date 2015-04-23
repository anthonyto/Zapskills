require "rails_helper"

RSpec.describe "the signin_signup process", :type => :feature do

  it "go to homepage" do
    visit "/users/sign_up"
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  it "checks footer links" do
    visit "/users/sign_up"
    click_link 'About'
    expect(page).to have_content 'About us page!'
    click_link 'Help'
    expect(page).to have_content 'Help!'
    click_link 'How To'
    expect(page).to have_content 'How to'
    click_link 'Contact'
    expect(page).to have_content 'Contact Us'
    click_link 'Terms and Conditions'
    expect(page).to have_content 'Terms and Conditions'
  end

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

  it "check header buttons change before/after signup" do
    visit ''
    click_link 'Sign Up'
    expect(page).to have_selector(:link_or_button, 'Login')
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end

end
