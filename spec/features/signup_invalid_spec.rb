require "rails_helper"

RSpec.describe "Signup process: ", :type => :feature do

  before :each do
    sleep(1)
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    visit ''
    click_link 'Get Started Today!'
  end

  scenario "7 character password" do
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "passwor"
    fill_in "Password confirmation", :with => "passwor"
    click_button "Sign up"
    expect(page).to have_content "Password is too short"
  end
  
  scenario "password and password confirmation do not match" do
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password1"
    click_button "Sign up"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario "7 character password" do
    fill_in "user_email", :with => "user@example.com"
    fill_in "Password", :with => "passwor"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content "Password is too short"
  end

  scenario "user already exists: different password" do
    fill_in "user_email", :with => "shachiagarwalla@gmail.com"
    fill_in "Password", :with => "password1"
    fill_in "Password confirmation", :with => "password1"
    click_button "Sign up"
    expect(page).to have_content "Email has already been taken"
  end
 
  scenario "user already exists: same password" do
    fill_in "user_email", :with => "shachiagarwalla@gmail.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content "Email has already been taken"
  end
end
