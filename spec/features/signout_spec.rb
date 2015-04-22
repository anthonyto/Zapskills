require "rails_helper"

RSpec.feature "the signout process", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password")
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
end
