require "rails_helper"

RSpec.feature "Search: ", :type => :feature do
  before :each do
    load Rails.root + "db/skill_seeds.rb"
    sleep (2)
    User.create(:email => "user@example.com", :password => "password", :city => "Madison", :zip_code => "53726", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Search")
#User 1
    click_link("Profile")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link("Sign Out")
#User 2
    User.create(:email => "user_second@example.com", :password => "password", :city => "New York", :zip_code => "10001", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_second"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
  end

#Search till far away- large radius (Around me checked)
  scenario "search for a skill for a very large distance, same skill available in far away city and searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "1000"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to have_content "dummy"
    page.should have_selector('table tr', :count => 3)
  end

  scenario "search for a skill for a very large distance, same skill available only in searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Cooking", :from => "skill_id"
    fill_in "Radius", :with => "1000"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for a skill for a very large distance, same skill available only in far away city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "1000"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to_not have_content "user_second"
    expect(page).to have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

#Search nearby- large radius (Around me checked)
  scenario "search for a skill for a large distance, same skill available in far away city and searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "100"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for a skill for a large distance, same skill available only in searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Cooking", :from => "skill_id"
    fill_in "Radius", :with => "100"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for a skill for a large distance, same skill available only in far away city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "100"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to_not have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 1)
  end

#Search nearby- small radius (Around me checked)
  scenario "search for a skill for a small distance, same skill available in far away city and searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for a skill for a small distance, same skill available only in searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Cooking", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for a skill for a small distance, same skill available only in far away city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10002", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to_not have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 1)
  end

#Two zip codes a little far: search within 1 mile
  scenario "search for a skill for a very small distance, with zip codes little far: same skill available in far away city and searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10030", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "1"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to_not have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 1)
  end

  scenario "search for a skill for a very small distance, with zip codes little far: same skill available only in searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10030", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Cooking", :from => "skill_id"
    fill_in "Radius", :with => "1"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to_not have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 1)
  end

  scenario "search for a skill for a very small distance, with zip codes little far: same skill available only in far away city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10030", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "1"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to_not have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 1)
  end

#Two zip codes a little far: search within 50 miles
  scenario "search for a skill for a small distance, with zip codes little far: same skill available in far away city and searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10030", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "50"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for a skill for a small distance, with zip codes little far: same skill available only in searcher's city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10030", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Cooking", :from => "skill_id"
    fill_in "Radius", :with => "50"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for a skill for a small distance, with zip codes little far: same skill available only in far away city- Around me checked" do
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Cooking", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
#User 3- Searcher
    click_link("Sign Out")
    User.create(:email => "user_third@example.com", :password => "password", :city => "New York", :zip_code => "10030", :state => "NY")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "New York", :from => "user_state"
    fill_in "Date of birth", :with => "1999-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "50"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to_not have_content "user_second"
    expect(page).to_not have_content "dummy"
    page.should have_selector('table tr', :count => 1)
  end

end
