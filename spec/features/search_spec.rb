require "rails_helper"

RSpec.feature "the profile visiting and editing", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
  end

  scenario "visit search page" do
    click_link("Search")
    expect(page).to have_content "Zapskills Home Search for skills:"
  end

  scenario "go to profile page from search" do
    click_link("Search")
    click_link("Profile")
    expect(page).to have_content "Editing User"
  end

  scenario "sign out from search page" do
    click_link("Search")
    click_link("Sign Out")
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end

end
