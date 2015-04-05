require "rails_helper"

RSpec.feature "the profile visiting and editing", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password")
  end

  scenario "visit profile page" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
    click_link("Profile")
    expect(page).to have_content "Editing User"
  end

  scenario "update profile" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    #expect(page).to have_content "Update User"
    fill_in "First name", :with => "user"
    fill_in "Last name", :with => "example"
    click_button "Update User"
    expect(page).to have_content "User was successfully updated"
  end
end
