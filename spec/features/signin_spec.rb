require "rails_helper"

RSpec.feature "Signin process: ", :type => :feature do
  before :each do
    visit "/users/sign_in"
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    sleep(1)
  end

  scenario "invalid password" do
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "invalid_pwd"
    end
    click_button "Log in"
    expect(page).to have_content "Invalid email or password"
  end

  scenario "invalid email" do
    within("#new_user") do
      fill_in "Email", :with => "sagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to have_content "Invalid email or password"
  end

  scenario "confirmation instruction" do
    click_link 'Didn\'t receive confirmation instructions?'
    expect(page).to have_selector(:link_or_button, 'Resend Confirmation Instructions')
    fill_in "Email", :with => "shachiagarwalla@gmail.com"
    click_button "Resend Confirmation Instructions"
    expect(page).to have_content "You will receive an email with instructions for how to confirm your email address in a few minutes"
    ActionMailer::Base.deliveries.last.body.match("Welcome shachiagarwalla@gmail.com!")
    ActionMailer::Base.deliveries.last.body.match("You can confirm your account email through the link below:")
    ActionMailer::Base.deliveries.last.body.match("Confirm my account")
    ActionMailer::Base.deliveries.last.subject.match("Confirmation instructions")
  end

  scenario "confirmation instruction: invalid email" do
    click_link 'Didn\'t receive confirmation instructions?'
    expect(page).to have_selector(:link_or_button, 'Resend Confirmation Instructions')
    fill_in "Email", :with => "sagarwalla@gmail.com"
    click_button "Resend Confirmation Instructions"
    expect(page).to have_content "Email not found"
  end

  scenario "sign in" do
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end

  given(:other_user) { User.create(:email => 'other@example.com', :password => 'rous') }

  scenario "Sign in for a not signed up user" do
    within("#new_user") do
      fill_in "Email", :with => other_user.email
      fill_in "Password", :with => other_user.password
    end
    click_button "Log in"
    expect(page).to have_content 'Invalid email or password'
  end
  
  scenario "sign me in from sign up page" do
    visit '/users/sign_up'
    click_link "Login"
    expect(page).to have_selector(:link_or_button, 'Log in')
    expect(page).to have_content 'Welcome Back! Email Password Remember me Not yet a member? Sign up here. Forgot your password? Didn\'t receive confirmation instructions?'
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end
  
  scenario "double sign in" do
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    visit "/users/sign_in"
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end
  
  scenario "remember me not checked" do
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
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    check('user_remember_me')
    click_button "Log in"
    expire_cookies
    visit "/users/sign_in"
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end

  scenario "signup after signin in (Not allowed)" do
    within("#new_user") do
      fill_in "Email", :with => "shachiagarwalla@gmail.com"
      fill_in "Password", :with => "password"
    end
    click_button "Log in"
    visit '/users/sign_up'
    expect(page).to_not have_content 'Sign Up'
    expect(page).to_not have_selector(:link_or_button, 'Login')
    expect(page).to_not have_selector(:link_or_button, 'Sign Up')
    expect(page).to have_selector(:link_or_button, 'Sign Out')
    expect(page).to have_selector(:link_or_button, 'Search')
    expect(page).to have_selector(:link_or_button, 'Profile')
  end
end
