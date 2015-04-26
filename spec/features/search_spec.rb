require "rails_helper"

RSpec.feature "Search: ", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password", :city => "Madison", :zip_code => "53726", :state => "WI")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
  end

  scenario "visit search page" do
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_content "Skill"
    # Test checkbox functionality here
    # expect(page).to have_content "City State Radius"
  end

  scenario "visit profile page from search page" do
    click_link("Profile")
    expect(page).to have_selector(:link_or_button, 'Update')
    expect(page).to have_content "Please complete your profile before proceeding. UPDATE PROFILE"
  end

=begin
  scenario "search query shows no results (valid entries)" do
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
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end
  
  scenario "search query shows some result (valid entries)" do
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
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end
=end
  
end
