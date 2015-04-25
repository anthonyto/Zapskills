require "rails_helper"

RSpec.feature "the footer to homepage process:", :type => :feature do
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

  it "About" do
    click_link 'About'
  end

  it "Help!" do
    click_link 'Help'
  end

  it "How to" do
    click_link 'How To'
  end

  it "Contact Us" do
    click_link 'Contact'
  end

  it "Terms and Conditions" do
    click_link 'Terms and Conditions'
  end
end
