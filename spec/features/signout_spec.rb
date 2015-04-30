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
  
   scenario "sign out from update profile" do
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

  scenario "sign out from edit profile" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Edit")
    expect(page).to have_content "Update Profile"
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

  scenario "add skills page" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    expect(page).to have_content "New Skill"
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
        click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Search")
    expect(page).to have_content "Around me"
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end
end
