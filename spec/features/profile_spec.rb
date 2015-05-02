require "rails_helper"

RSpec.feature "User Profile: ", :type => :feature do
  before :each do
    sleep(2)
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
    expect(page).to have_content "Please complete your profile before proceeding. Update Profile"
  end

  scenario "update profile first time" do
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content "Madison"
  end

  scenario "update profile with invalid date" do
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989"
    click_button("Update")
    expect(page).to have_content "Please complete your profile before proceeding. Update Profile"
  end
  
  scenario "go to add skills page from Profile" do
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    expect(page).to have_content "New Skill"
  end

  scenario "actually add skills" do
    load Rails.root + "db/skill_seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "Edit Skill Delete" 
  end

  scenario "delete skills" do
    load Rails.root + "db/skill_seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "Edit Skill Delete"
    click_link("Delete")
    expect(page).to_not have_content "Cooking"
  end

  scenario "adding after deleting skills" do
    load Rails.root + "db/skill_seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link("Delete")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Intermediate", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "Edit Skill Delete"
  end

  scenario "edit skills" do
    load Rails.root + "db/skill_seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link("Edit Skill")
    select "Intermediate", :from =>  "Level"
    click_button "Submit"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "Edit Skill Delete"
  end

  scenario "adding multiple skills" do
    load Rails.root + "db/skill_seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link 'Add Skill'
    fill_in "Description", :with => "Learned it twice"
    select "Guru", :from =>  "Level"
    select "Piano", :from => "experience_skill_id"
    fill_in "Start date", :with => "2009-11-23"
    click_button "Submit"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "Skills Subject Level"
    expect(page).to have_content "Piano"
    expect(page).to have_content "Edit Skill Delete"
  end
  
  scenario "adding same skill multiple times" do
    load Rails.root + "db/skill_seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    expect(page).to have_content "Cooking"
    expect(page).to have_content "Edit Skill Delete"
    click_link 'Add Skill'
    fill_in "Description", :with => "Learned it twice"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "2009-11-23"
    click_button "Submit"
    expect(page).to have_content "you already have that skill"
  end

  scenario "adding multiple skills multiple times" do
    load Rails.root + "db/skill_seeds.rb"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link 'Add Skill'
    fill_in "Description", :with => "Learned it twice"
    select "Guru", :from =>  "Level"
    select "Piano", :from => "experience_skill_id"
    fill_in "Start date", :with => "2009-11-23"
    click_button "Submit"
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    expect(page).to have_content "you already have that skill"
    click_link("Profile")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Piano", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    expect(page).to have_content "you already have that skill"
  end

  scenario "edit user" do
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link "Edit"
    fill_in "City", :with => "Madison"
    select "Ohio", :from => "user_state"
    click_button "Update"
    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content "LocationMadison"
  end

  scenario "search page from profile" do
    click_link("Search")
    expect(page).to have_content "Please complete your profile before proceeding. Update Profile"
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    fill_in "City", :with => "Madison"
    select "Wisconsin", :from => "user_state"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link "Edit"
    fill_in "City", :with => "Madison"
    select "Ohio", :from => "user_state"
    click_button "Update"
    click_link("Search") 
    expect(page).to have_content "Skill"
    expect(page).to have_content "Radius"
    expect(page).to have_content "Around me"
  end
end
