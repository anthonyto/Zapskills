require "rails_helper"

RSpec.feature "the signin process", :type => :feature do
  before :each do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
  end

  it "go to homepage" do
    visit "/users/sign_in"
    click_link 'ZapSkills'
    expect(page).to have_content 'Welcome to ZapSkills'
    expect(page).to have_content 'What is ZapSkills'
  end

  it "checks footer links" do
    visit "/users/sign_in"
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

  scenario "click on search does nothing" do
    visit "/users/sign_in"
    click_link 'Search'
    expect(page).to have_selector(:link_or_button, 'Log in')
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario "confirmation instruction" do
    visit "/users/sign_in"
    click_link 'Didn\'t receive confirmation instructions?'
    expect(page).to have_selector(:link_or_button, 'Resend confirmation instructions')
    expect(page).to have_content 'Resend confirmation instructions'
  end

  scenario "send confirmation instruction" do
    visit "/users/sign_in"
    click_link 'Didn\'t receive confirmation instructions?'
    fill_in "Email", :with => "shachiagarwalla@gmail.com"
    click_button "Resend confirmation instructions"
    ActionMailer::Base.deliveries.last.body.match("Welcome shachiagarwalla@gmail.com!")
    ActionMailer::Base.deliveries.last.body.match("You can confirm your account email through the link below:")
    ActionMailer::Base.deliveries.last.body.match("Confirm my account")
    ActionMailer::Base.deliveries.last.subject.match("Confirmation instructions")
  end

  scenario "signs me in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
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
    click_link "Login"
    expect(page).to have_selector(:link_or_button, 'Log in')
    expect(page).to have_content 'Welcome Back! Email Password Remember me Forgot your password? Didn\'t receive confirmation instructions?'
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
  end
  
  scenario "double sign in" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    visit "/users/sign_in"
    expect(page).to have_content "You are already signed in"
  end
  
  scenario "remember me not checked" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expire_cookies
    visit "/users/sign_in"
    expect(page).to have_content 'Welcome Back'
  end

  scenario "remember me checked" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    check('user_remember_me')
    click_button "Log in"
    expire_cookies
    visit "/users/sign_in"
    expect(page).to have_content 'You are already signed in'
  end

end
