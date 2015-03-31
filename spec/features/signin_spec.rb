require "rails_helper"

RSpec.describe "the signin process", :type => :feature do
  before :each do
    User.create(:email => 'user@example.com', :password => 'password')
  end

  it "signs me in" do
    visit ''
    #within("#new") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    #end
    click_button 'Log in'
    expect(page).to have_content 'successfully'
  end
end
