require "rails_helper"

RSpec.feature "Search: ", :type => :feature do
  before :each do
    load Rails.root + "db/skill_seeds.rb"
    sleep(3)
    User.create(:email => "user@example.com", :password => "password", :city => "Madison", :zip_code => "53726", :state => "WI")
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
  end

  scenario "dont fill skill, stars, but fill description, reviewee, reviewer, third user can see" do
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    click_link("Sign Out")
#Reviewee
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "No Reviews"
    expect(page).to_not have_content "Edit Review"
    click_link("Sign Out")

#Reviewer
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "No Reviews"
    expect(page).to have_content "Edit Review"
    click_link("Sign Out")

#Third user
    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "No Reviews"
    expect(page).to_not have_content "Edit Review"
  end

  scenario "leave description empty, reviewee, reviewer, third user cannot see" do
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    click_button("Submit")
    click_link("Sign Out")
#Reviewee
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "No Reviews"
    page.should have_selector('table tr', :count => 2)
    click_link("Sign Out")

#Reviewer
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 2)
    expect(page).to have_content "No Reviews"
    expect(page).to_not have_content "Edit Review"
    click_link("Sign Out")

#Third user
    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to_not have_content "Great job"
    expect(page).to have_content "No Reviews"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "add and check for review" do
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"
    click_link("Sign Out")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
  end

  scenario "search for the skill and write a review, reviewee cannot edit" do
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    expect(page).to have_content "Edit Review"
    expect(page).to have_content "Delete Review" 
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"
    click_link("Sign Out")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"
  end

  scenario "search for the skill and write and delete the review, check reviewee, reviewer and third user cannot see" do
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    page.should have_selector('table tr', :count => 4)
    click_link("Delete Review")
    expect(page).to have_content "Review was successfully destroyed."
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 2)
    expect(page).to have_content "No Reviews"
    expect(page).to have_content "Profile"
    expect(page).to have_content "dummy"
    click_link("Sign Out")

#Reviewee
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to_not have_content "Great job"
    expect(page).to have_content "No Reviews"
    page.should have_selector('table tr', :count => 2)
    click_link("Sign Out")

#Reviewer
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to_not have_content "Great job"
    expect(page).to have_content "No Reviews"
    page.should have_selector('table tr', :count => 2)
    expect(page).to_not have_content "Edit Review"
    click_link("Sign Out")

#Third user
    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to_not have_content "Great job"
    expect(page).to have_content "No Reviews"
    page.should have_selector('table tr', :count => 2)
  end

  scenario "search for the skill and write a review and a 3rd user cannot edit" do
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"
    click_link("Sign Out")

    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click

    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"
  end

  scenario "search for the skill and write and edit the review, check reviewee, reviewer and third user see edited review" do
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    page.should have_selector('table tr', :count => 4)
    click_link("Edit Review")
    expect(page).to have_content "Edit A Review"
    fill_in "Body", :with => "Awesome one"
    click_button("Submit")
    expect(page).to have_content "Review was successfully updated."
    expect(page).to have_content "Awesome one"
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"
    expect(page).to have_content "dummy"
    expect(page).to have_content "Edit Review"
    expect(page).to have_content "Delete Review"
    click_link("Sign Out")

#Reviewee
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Awesome one"
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"
    click_link("Sign Out")

#Reviewer
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Awesome one"
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Edit Review"
    expect(page).to have_content "Delete Review"
    click_link("Sign Out")

#Third user
    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Awesome one"
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"    
  end

  scenario "2 users add review for the same user's same skill" do
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"
    click_link("Sign Out")

#Third User profile
    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    click_link("Add Review")
    expect(page).to have_content "Write A Review"
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Awesome one"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 5)
    click_link("Sign Out")

#Reviewee
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 5)
    expect(page).to_not have_content "No Reviews"
    expect(page).to_not have_content "Edit Review"
    click_link("Sign Out")

#Reviewer
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 5)
    expect(page).to_not have_content "No Reviews"
    expect(page).to have_content "Edit Review"
    expect(page).to have_content("Edit Review", :count => 1)
    find(:xpath, "//tr[td[contains(.,'Great job')]]/td/a", :text => 'Edit Review').click
    expect(page).to have_content "Edit A Review"
    click_link("Sign Out")

#Third User
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 5)
    expect(page).to_not have_content "No Reviews"
    expect(page).to have_content("Edit Review", :count => 1)
    find(:xpath, "//tr[td[contains(.,'Awesome one')]]/td/a", :text => 'Edit Review').click
    expect(page).to have_content "Edit A Review"
    click_link("Sign Out")
  end

  scenario "1 user adds reviews for 2 skills of the same user" do 
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"
    click_link("Sign Out")

#First user-second skill
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Piano", :from => "experience_skill_id"
    fill_in "Start date", :with => "2009-11-23"
    click_button "Submit"
    click_link("Sign Out")

#Second user second review add
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Guru", :from =>  "Level"
    select "Piano", :from => "experience_skill_id"
    fill_in "Start date", :with => "1999-11-23"
    click_button "Submit"
    click_link("Search")
    select "Piano", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    click_link("Add Review")
    expect(page).to have_content "Write A Review"
    select "Piano", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Awesome one"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    expect(page).to have_content "Piano"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 6)
    click_link("Sign Out")

#Reviewee
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 6)
    expect(page).to_not have_content "No Reviews"
    expect(page).to_not have_content "Edit Review"
    click_link("Sign Out")

#Reviewer
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 6)
    expect(page).to_not have_content "No Reviews"
    expect(page).to have_content "Edit Review"
    expect(page).to have_content("Edit Review", :count => 2)
    find(:xpath, "//tr[td[contains(.,'Great job')]]/td/a", :text => 'Edit Review').click
    expect(page).to have_content "Edit A Review"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 6)
    expect(page).to_not have_content "No Reviews"
    expect(page).to have_content "Edit Review"
    expect(page).to have_content("Edit Review", :count => 2)
    find(:xpath, "//tr[td[contains(.,'Awesome one')]]/td/a", :text => 'Edit Review').click
    expect(page).to have_content "Edit A Review"
    click_link("Sign Out")

#Third User
    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Awesome one"
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 6)
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"
  end

  scenario "1 user adds reviews for 1 skill of two different user" do
    click_link("Sign Out")
#Third user
    User.create(:email => "user_third@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "user_third"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    click_link("Add Review")
    expect(page).to have_content "Write A Review"
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Great job"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"

    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'user_second').click
    click_link("Add Review")
    expect(page).to have_content "Write A Review"
    select "Camping", :from => "review_skill_id"
    select "5", :from =>  "Stars"
    fill_in "Body", :with => "Awesome one"
    click_button("Submit")
    expect(page).to have_content "Review was successfully created."
    expect(page).to have_content "Camping"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 4)
    expect(page).to have_content "Profile"
    click_link("Sign Out")

#First user
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Great job"
    expect(page).to_not have_content "No Reviews"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"
    click_link("Sign Out")

#Second User
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_second@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    expect(page).to have_content "Awesome one"
    expect(page).to_not have_content "No Reviews"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "No Reviews"
    expect(page).to_not have_content "Edit Review"
    click_link("Sign Out")

#Third User
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_third@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to have_content "Great job"
    expect(page).to_not have_content "Awesome one"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "No Reviews"
    expect(page).to have_selector(:link_or_button, 'Edit Review')
    expect(page).to have_selector(:link_or_button, 'Delete Review')
    expect(page).to have_content("Edit Review", :count => 1)
    expect(page).to have_content("Delete Review", :count => 1)
    find(:xpath, "//tr[td[contains(.,'Great job')]]/td/a", :text => 'Edit Review').click
    expect(page).to have_content "Edit A Review"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 3)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'user_second').click
    expect(page).to_not have_content "Great job"
    expect(page).to have_content "Awesome one"
    page.should have_selector('table tr', :count => 4)
    expect(page).to_not have_content "No Reviews"
    expect(page).to have_selector(:link_or_button, 'Edit Review')
    expect(page).to have_selector(:link_or_button, 'Delete Review')
    expect(page).to have_content("Edit Review", :count => 1)
    expect(page).to have_content("Delete Review", :count => 1)
    find(:xpath, "//tr[td[contains(.,'Awesome one')]]/td/a", :text => 'Edit Review').click
    expect(page).to have_content "Edit A Review"
  end
end
