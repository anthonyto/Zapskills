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
    fill_in "State", :with => "Wisconsin"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "4", :from =>  "Level"
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
    fill_in "State", :with => "Wisconsin"
    fill_in "Date of birth", :with => "1989-11-23"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "5", :from =>  "Level"
    select "Piano", :from => "experience_skill_id"
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
    expect(page).to have_content "WRITE A REVIEW"
  end

  scenario "leave description empty, reviewee, reviewer, third user do not see any review" do
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
    page.should have_selector('table tr', :count => 3)
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
    page.should have_selector('table tr', :count => 3)
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
    fill_in "State", :with => "Wisconsin"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 3)

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
    page.should have_selector('table tr', :count => 3)
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
    page.should have_selector('table tr', :count => 3)
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
    page.should have_selector('table tr', :count => 3)
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
    fill_in "State", :with => "Wisconsin"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
    find(:xpath, "//tr[td[contains(.,'Camping')]]/td/a", :text => 'dummy').click
    expect(page).to_not have_content "Great job"
    page.should have_selector('table tr', :count => 3)
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
    fill_in "State", :with => "Wisconsin"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
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
    expect(page).to have_content "EDIT A REVIEW"
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
    fill_in "State", :with => "Wisconsin"
    fill_in "Date of birth", :with => "1991-11-23"
    click_button("Update")
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
    expect(page).to_not have_content "Edit Review"
    expect(page).to_not have_content "Delete Review"    
  end
end
