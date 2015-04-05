require "rails_helper"

RSpec.feature "the signin process", :type => :feature do
  before :each do
    User.create(:email => "user@example.com", :password => "password")
  end

  scenario "signs me in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
  end

  given(:other_user) { User.create(:email => 'other@example.com', :password => 'rous') }

  scenario "Signing in as another user" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => other_user.email
      fill_in "Password", :with => other_user.password
    end
    click_button "Log in"
    expect(page).to have_content 'Invalid email or password'
  end
  
  it "signs me in from sign up" do
    visit '/users/sign_up'
    click_link 'Log in'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Forgot your password?'
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
  end
  
  scenario "double sign in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    visit "/users/sign_in"
    expect(page).to have_content "You are already signed in"
  end
end
