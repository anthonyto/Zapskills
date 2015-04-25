require "rails_helper"

RSpec.feature "check header buttons after signing in: ", :type => :feature do
  before :each do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
  end
  after :each do
    expect(page).to have_selector(:link_or_button, 'Login')
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end

  scenario "forgot password page" do
    visit "users/sign_in"
    click_link 'Forgot your password?'
    fill_in "Email", :with =>"shachiagarwalla@gmail.com"
    click_button "Send me reset password instructions"
  end

  scenario "homepage" do
    visit ""
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "Signin Page" do
    visit "/users/sign_in"
  end

  scenario "Sign out Page" do
    User.create(:email => "user@example.com", :password => "password")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    click_link("Sign Out")
  end

  scenario "Signup Page" do
    visit "/users/sign_up"
  end  
end
