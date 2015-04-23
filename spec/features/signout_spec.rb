require "rails_helper"

RSpec.feature "the signout process", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password")
  end

  it "go to homepage" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Sign Out")
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  it "checks footer links" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Sign Out")
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

  scenario "signs me out after signing in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

  scenario "signing out without signing in redirects to signin page" do
    visit "/users/sign_out"
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end
  
  scenario "header links check before and after signing out" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
    click_link("Sign Out")
    expect(page).to have_selector(:link_or_button, 'Login')
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end
end
