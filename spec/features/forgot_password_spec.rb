require "rails_helper"

RSpec.describe "the forgot password process", :type => :feature do

  it "forgot pwd" do
    visit ''
    click_link 'Forgot your password'
    expect(page).to have_content 'Forgot your password?'
  end
end
