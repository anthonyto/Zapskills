require "rails_helper"

RSpec.feature "Signout process: ", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password")
  end

  scenario "After signing in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

  scenario "Without signing in redirects to signin page" do
    visit "/users/sign_out"
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end
  
   scenario "sign out from profile" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

  scenario "sign out from search" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end
end
