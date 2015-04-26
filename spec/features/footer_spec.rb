require "rails_helper"

RSpec.feature "the footer to homepage process: ", :type => :feature do
  before :each do
    visit ""
  end
  after :each do
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
    expect(page).to have_selector(:link_or_button, 'Login')
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end

  scenario "About page to home" do
    click_link 'About'
  end

  scenario "Help page to home" do
    click_link 'Help'
  end

  scenario "How to page to home" do
    click_link 'How To'
  end

  scenario "Contact Us page to home" do
    click_link 'Contact'
  end

  scenario "Terms and Conditions page to home" do
    click_link 'Terms and Conditions'
  end
end
