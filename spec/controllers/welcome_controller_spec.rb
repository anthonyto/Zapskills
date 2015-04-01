require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe WelcomeController, :type => :controller do
  describe "GET search" do
    it "response should be success" do
      #@user = FactoryGirl.create :user
      sign_in
      get :search
      flash[:notice].should be_nil
      response.should be_success
      response.should render_template("search")
    end
#TODO: Skill responds as empty
    it "skills is not empty" do
      @user = FactoryGirl.create :user
      sign_in 
      get :search
      assigns(:skills).should be_empty
    end
    it "responds unsuccessfully" do
      sign_in nil
      get :search
      response.should_not be_success
    end
  end

#TODO: Results tests
  describe "GET results" do
    it "response should be success" do
      #@user = FactoryGirl.create :user
      sign_in
      get :results
      flash[:notice].should be_nil
      response.should be_success
      response.should render_template("search")
    end
    it "responds unsuccessfully" do
      sign_in nil
      get :search
      response.should_not be_success
    end
  end
end
