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

  scenario "visit profile page" do
    click_link("Profile")
    expect(page).to have_content "Editing User"
  end

  scenario "update profile" do
    click_link("Profile")
    fill_in "First name", :with => "user"
    fill_in "Last name", :with => "example"
    click_button "Update User"
    expect(page).to have_content "User was successfully updated"
  end
  
  scenario "updated profile" do
    click_link("Profile")
    fill_in "First name", :with => "user"
    fill_in "Last name", :with => "example"
    click_button "Update User"
    expect(page).to have_content "First name: user"
    expect(page).to have_content "Last name: example"
  end

  scenario "go to add skills page from edit profile" do
    click_link("Profile")
    click_button "Update User"
    click_link("Add skills")
    expect(page).to have_content "New Skill"
  end

  scenario "actually add skills" do
    load Rails.root + "db/seeds.rb"
    click_link("Profile")
    click_button "Update User"
    click_link("Add skills")
    fill_in "Description", :with => "Learned it"
    fill_in "experience_level", :with => "4"
    select "2010", :from => "experience_start_date_1i"
    select "November", :from => "experience_start_date_2i"
    select "20", :from => "experience_start_date_3i"
    select "Cooking", :from => "experience_skill_id"
    click_button "Create Experience"
    expect(page).to have_content "Skills"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "Description: Learned it"
    expect(page).to have_content "Level: 4"
  end

  scenario "edit user" do
    click_link("Profile")
    click_button "Update User"
    click_link("Edit")
    expect(page).to have_content "Editing User"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    click_button "Update User"
    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content "City: Madison"
    expect(page).to have_content "State: WI"
  end

  scenario "sign out from profile" do
    click_link("Profile")
    click_link("Sign Out")
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end

  scenario "search page from profile" do
    click_link("Profile")
    click_link("Search")
    expect(page).to have_content "Zapskills Home Search for skills:"
  end
end
