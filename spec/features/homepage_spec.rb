require "rails_helper"

RSpec.feature "visit homepage", :type => :feature do
  before :each do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
  end

  scenario "do nothing" do
    visit ""
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "do nothing anc check footer text" do
    visit ""
    expect(page).to have_content 'About Help How To Contact Terms and Conditions'
  end

  scenario "and click on Zapskills" do
    visit ""
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "and click on Login" do
    visit ""
    click_link 'Login'
    expect(page).to have_content 'Welcome Back!'
    expect(page).to have_selector(:link_or_button, 'Log in')
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "and click on Signup" do
    visit ""
    click_link 'Sign Up'
    expect(page).to have_content 'SIGN UP'
    expect(page).to have_selector(:link_or_button, 'Sign up')
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  scenario "and click on Search" do
    visit ""
    click_link 'Search'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Welcome Back!'
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end


end
