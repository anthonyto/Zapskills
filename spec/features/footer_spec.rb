require "rails_helper"

RSpec.feature "the footer to homepage process:", :type => :feature do
  it "About" do
    visit ""
    click_link 'About'
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
    expect(page).to have_selector(:link_or_button, 'Login')
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end

  it "Help!" do
    visit ""
    click_link 'Help'
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end

  it "How to" do
    visit ""
    click_link 'How To'
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end

  it "Contact Us" do
    visit ""
    click_link 'Contact'
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end

  it "Terms and Conditions" do
    visit ""
    click_link 'Terms and Conditions'
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
    expect(page).to have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to_not have_selector(:link_or_button, 'Sign Out')
    expect(page).to_not have_selector(:link_or_button, 'Profile')
  end

end
