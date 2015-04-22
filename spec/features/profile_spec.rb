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

 it "go to homepage" do
    click_link("Profile")
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "visit profile page" do
    click_link("Profile")
    expect(page).to have_content "Please complete your profile before proceeding. UPDATE PROFILE"
  end

  it "checks footer links" do
    click_link("Profile")
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

  scenario "update profile" do
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    click_button "Update"
    expect(page).to have_selector(:link_or_button, 'Edit')
    expect(page).to have_content "User was successfully updated"
  end
  
  scenario "updated profile" do
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    click_button "Update"
    expect(page).to have_content "dummy"
    expect(page).to have_content "example"
  end

#TODO: Add button presence
  scenario "go to add skills page from edit profile" do
    click_link("Profile")
    click_button "Update"
    click_link("Edit")
    expect(page).to have_content "New Skill"
    click_link("Add skills")
    expect(page).to have_content "New Skill"
  end

  scenario "actually add skills" do
    load Rails.root + "db/seeds.rb"
    click_link("Profile")
    click_button "Update"
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
  
  scenario "adding same skills multiple times" do
#Fails presently because multiple entries of the same skill is allowed
    load Rails.root + "db/seeds.rb"
    click_link("Profile")
    click_button "Update"
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
    click_link("Add skills")
    fill_in "Description", :with => "Learned it"
    fill_in "experience_level", :with => "4"
    select "2010", :from => "experience_start_date_1i"
    select "November", :from => "experience_start_date_2i"
    select "20", :from => "experience_start_date_3i"
    select "Cooking", :from => "experience_skill_id"
    click_button "Create Experience"
    expect(page).to have_content "Skill already added"
  end

  scenario "edit user" do
    click_link("Profile")
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
    click_link("Profile")
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

  scenario "sign out from profile" do
    click_link("Profile")
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

  scenario "search page from profile" do
    click_link("Profile")
    click_link("Search")
    expect(page).to have_content "Skill"
    expect(page).to have_content "City State Radius"
  end
end
