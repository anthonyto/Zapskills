require "rails_helper"

RSpec.feature "User Profile: ", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
  end

  scenario "visit profile page" do
    expect(page).to have_content "Please complete your profile before proceeding. UPDATE PROFILE"
  end

  scenario "update profile first time" do
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content "Madison"
  end
  
  scenario "go to add skills page from Profile" do
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    expect(page).to have_content "NEW SKILL"
  end

  scenario "actually add skills" do
    load Rails.root + "db/seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    expect(page).to have_content "NEW SKILL"
    fill_in "Description", :with => "Learned it"
    select "4", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Create"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "4"
    expect(page).to have_content "Skills Subject Level"
  end
  
  scenario "adding same skills multiple times" do
    load Rails.root + "db/seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "4", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Create"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "4"
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it twice"
    select "5", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "2009-11-23"
    click_button "Create"
    expect(page).to have_content "Skill can't be duplicate"
  end

  scenario "edit user" do
    click_button "Update"
    click_link("Edit")
    expect(page).to have_content "Editing User"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    click_button "Update"
    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content "City: Madison"
    expect(page).to have_content "State: WI"
  end

  scenario "discarding changes to edit user" do
    click_button "Update"
    expect(page).to have_content "Please complete your profile before proceeding. UPDATE PROFILE"
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    click_button "Update"
    expect(page).to have_content "qwrty"
    click_button ("Edit")
    fill_in "City", :with => "Delhi"
    click_link("Show")
    expect(page).to have_content "City: Madison"
  end

  scenario "search page from profile" do
    click_link("Search")
    expect(page).to have_content "Skill"
    expect(page).to have_content "City State Radius"
  end
end
