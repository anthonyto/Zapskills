require "rails_helper"

RSpec.feature "Visit homepage: ", :type => :feature do
  before :each do
    visit ""
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    sleep(1)
  end

  after :each do
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "do nothing" do
    expect(page).to have_content 'More Contact How To Terms and Conditions'
  end

  scenario "from forgot password page" do
    visit "users/sign_in"
    click_link 'Forgot your password?'
    click_link 'ZapSkills'
  end

  scenario "click on Zapskills" do
    click_link 'ZapSkills'
  end

  scenario "click on Login" do
    click_link 'Login'
    expect(page).to have_content 'Welcome Back!'
    expect(page).to have_selector(:link_or_button, 'Log in')
    click_link 'ZapSkills'
  end

  scenario "click on Signup" do
    click_link 'Get Started Today!'
    expect(page).to have_content 'Sign Up'
    expect(page).to have_selector(:link_or_button, 'Sign up')
    click_link 'ZapSkills'
  end

  scenario "Sign out and then click" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Sign Out")
    click_link 'ZapSkills'
  end

  scenario "Search page without logging in" do
    click_link 'Search'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Welcome Back!'
    click_link 'ZapSkills'
  end

  scenario "After logging in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link 'ZapSkills'
  end
  
  scenario "Search page after logging in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Search")
    click_link 'ZapSkills'
  end

  scenario "Update Profile Page" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
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
    click_link 'ZapSkills'
  end

  scenario "Profile page" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Profile")
    click_link 'ZapSkills'
  end

  scenario "Profile Page: Add Experiences page" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
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
    click_link 'ZapSkills'
  end
end
