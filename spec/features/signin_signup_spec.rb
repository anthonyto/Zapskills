require "rails_helper"

RSpec.describe "the signin_signup process", :type => :feature do

  it "signs me up from sign in" do
    visit ''
    click_link 'Sign up'
    expect(page).to have_content 'Sign up'
  end
end
