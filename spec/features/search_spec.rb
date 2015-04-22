require "rails_helper"

RSpec.feature "the searching", :type => :feature do
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
    click_link("Search")
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "visit search page" do
    click_link("Search")
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_content "Skill"
    expect(page).to have_content "City State Radius"
  end

  it "checks footer links" do
    click_link("Search")
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

  scenario "go to profile page from search" do
    click_link("Search")
    click_link("Profile")
    expect(page).to have_selector(:link_or_button, 'Update')
    expect(page).to have_content "Please complete your profile before proceeding. UPDATE PROFILE"
  end

  scenario "sign out from search page" do
    click_link("Search")
    click_link("Sign Out")
    expect(page).to have_content "Signed out successfully"
  end

  scenario "search show no results" do
    load Rails.root + "db/seeds.rb"
    click_link("Search")
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Radius", :with => "1"
    select "Fishing", :from => "skill_id"
    click_button "Search"
    expect(page).to have_content "No results"
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_content "Skill"
    expect(page).to have_content "City State Radius"
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
  
  scenario "search show some result" do
    load Rails.root + "db/seeds.rb"
    click_link("Search")
    fill_in "City", :with => "Madison"
    fill_in "State", :with => "WI"
    fill_in "Radius", :with => "10"
    select "Cooking", :from => "skill_id"
    click_button "Search"
    expect(page).to have_content "Search Results"
    expect(page).to have_content "Tutor"
    expect(page).to have_content "Skills"
    expect(page).to have_content "Rating"
    page.should have_selector('table tr', :count => 13)
  end

end
