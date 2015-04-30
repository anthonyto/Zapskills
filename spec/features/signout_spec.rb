require "rails_helper"

RSpec.feature "Signout process: ", :type => :feature do
  before :each do
    sleep(1)
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

  scenario "search from search results" do
    load Rails.root + "db/skill_seeds.rb"
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "City", :with => "Madison"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link("Sign Out")
    User.create(:email => "user_second@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_second"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

  scenario "from add review page" do
    load Rails.root + "db/skill_seeds.rb"
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    click_link("Profile")
    fill_in "First name", :with => "dummy"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "City", :with => "Madison"
    fill_in "Zip code", :with => "53726"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link("Sign Out")
    User.create(:email => "user_second@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_second"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    click_link("Add Review")
    expect(page).to have_content "Write A Review"
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

end
