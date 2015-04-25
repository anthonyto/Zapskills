require "rails_helper"

RSpec.feature "check header buttons after signing in: ", :type => :feature do
  before :each do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
  end
  after :each do
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end

  scenario "just signed in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
  end

  scenario "just signed up" do
    visit "/users/sign_up"
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
  end

  scenario "Profile Page" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
  end

  scenario "Search Page" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
  end
end
