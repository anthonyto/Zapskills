require "rails_helper"

RSpec.describe "Forgot password process: ", :type => :feature do
  before :each do
    visit "users/sign_in"
    click_link 'Forgot your password?'
  end

  scenario "forgot password page contents" do
    expect(page).to have_selector(:link_or_button, 'Send me reset password instructions')
    expect(page).to have_content 'Forgot your password?'
  end

  scenario "forgot password form filling" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    fill_in "Email", :with =>"shachiagarwalla@gmail.com"
    click_button "Send me reset password instructions"
    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
    ActionMailer::Base.deliveries.last.body.match("Hello shachiagarwalla@gmail.com!")
    ActionMailer::Base.deliveries.last.body.match("Someone has requested a link to change your password. You can do this through the link below.")
    ActionMailer::Base.deliveries.last.body.match("Change my password")
    ActionMailer::Base.deliveries.last.body.match("If you didn't request this, please ignore this email.")
    ActionMailer::Base.deliveries.last.body.match("Your password won't change until you access the link above and create a new one.")
    ActionMailer::Base.deliveries.last.subject.match("Reset password instructions")
  end

  scenario "invalid user forgot password" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    fill_in "Email", :with =>"sagarwalla@gmail.com"
    click_button "Send me reset password instructions"
    expect(page).to have_content 'Email not found'
  end
end
