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

  scenario "After signign in" do
    User.create(:email => "user@example.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
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

  scenario "Confirmation instructions page" do
    visit "users/sign_in"
    click_link 'Didn\'t receive confirmation instructions?'
  end

  scenario "Homepage" do
    visit ""
  end
  
  scenario "Update Profile Page" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
  end

  scenario "Updated Profile Page" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
  end

  scenario "Profile Page: Add Experiences page" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
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
