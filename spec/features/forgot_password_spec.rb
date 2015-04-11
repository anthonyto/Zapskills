require "rails_helper"

RSpec.describe "the forgot password process", :type => :feature do

  it "forgot pwd" do
    visit ''
    click_link 'Forgot your password'
    expect(page).to have_content 'Forgot your password?'
  end

  it "forgot pwd fill form" do
    User.create(:email => "shachiagarwalla@gmail.com", :password => "password")
    visit ''
    click_link 'Forgot your password'
    fill_in "Email", :with =>"shachiagarwalla@gmail.com"
    click_button "Send me reset password instructions"
    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end
end
