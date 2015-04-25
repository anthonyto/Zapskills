require "rails_helper"

RSpec.feature "check footer links: ", :type => :feature do
  after :each do
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

  scenario "Signin page" do
    visit "/users/sign_in"
  end

  scenario "Signout" do
    User.create(:email => "user@example.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Sign Out")
  end
  
  scenario "Signup page" do
    visit "/users/sign_up"
  end

  scenario "Forgot Password page" do
    visit "users/sign_in"
    click_link 'Forgot your password?'
  end

  scenario "Homepage" do
    visit ""
  end

  scenario "Profile Page" do
    User.create(:email => "user@example.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
  end

  scenario "Search Page" do
    User.create(:email => "user@example.com", :password => "password", :city => "Madison", :zip_code => "53726", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
  end
end
