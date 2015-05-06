require "rails_helper"

RSpec.feature "Search: ", :type => :feature do
  before :each do
    load Rails.root + "db/skill_seeds.rb"
    sleep (1)
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
    click_button("Update")
    click_link("Profile")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    click_button "Submit"
    click_link("Sign Out")
    User.create(:email => "user_new@example.com", :password => "password", :city => "Madison", :zip_code => "53701", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user_new@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    fill_in "First name", :with => "dummy_new"
    fill_in "Last name", :with => "example"
    select "Wisconsin", :from => "user_state"
    click_button("Update")
    click_link("Add Skill")
    fill_in "Description", :with => "Learned it"
    select "Expert", :from =>  "Level"
    select "Camping", :from => "experience_skill_id"
    click_button "Submit"
    click_link("Search")
    select "Camping", :from => "skill_id"
    fill_in "Radius", :with => "10"
    click_button "Search"
    expect(page).to have_content "Search Results"
    page.should have_selector('table tr', :count => 2)
  end

   scenario "Signed out successfully" do
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    click_link "Sign Out"
    expect(page).to have_selector(:link_or_button, 'Get Started Today!')
  end

  scenario "Go to search" do
    expect(page).to have_selector(:link_or_button, 'Search')
    click_link("Search")
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_content "Skill"
    expect(page).to have_content "Around me"
    expect(page).to have_content "Radius (miles)"
  end

  scenario "Go to Profile" do
    expect(page).to have_selector(:link_or_button, 'Profile')
    click_link("Profile")
    expect(page).to have_content "user_new@example.com"
    expect(page).to have_content "Profile"
  end

  scenario "go to homepage" do
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
  end

  scenario "go to about page" do
    click_link 'How To'
    expect(page).to have_content 'How to'
  end

  scenario "go to contact" do
    click_link 'Contact'
    expect(page).to have_content 'Contact'
  end

  scenario "go to terms and conditions" do
    click_link 'Terms and Conditions'
    expect(page).to have_content 'Terms and Conditions'
  end

end
