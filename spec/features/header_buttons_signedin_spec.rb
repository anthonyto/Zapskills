require "rails_helper"

RSpec.feature "check header buttons after signing in: ", :type => :feature do
  before :each do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    sleep(1)
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

  scenario "Update Profile Page" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
  end

  scenario "Updated Profile Page" do
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
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    click_button("Update")
  end

  scenario "Profile Page: Add Experiences page" do
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
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    click_button("Update")
    click_link 'Add Skill'
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
