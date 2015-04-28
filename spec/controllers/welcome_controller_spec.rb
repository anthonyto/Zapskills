require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe WelcomeController, :type => :controller do
  describe "GET search" do
    it "response should be success" do
      @user = FactoryGirl.create :user
      sign_in @user
      get :search
      flash[:notice].should be_nil
      response.should be_success
      response.should render_template("search")
    end
    it "skills is not empty" do
      @user = FactoryGirl.create :user
      sign_in @user 
      get :search
      assigns(:skills).should be_empty
    end
    it "responds unsuccessfully" do
      sign_in nil
      get :search
      response.should_not be_success
    end
  end

  describe "GET results" do
    it "response should be success" do
      @user = FactoryGirl.create :user
      sign_in @user
      get :results
      flash[:notice].should eq("No results")
      response.should redirect_to(search_path)
    end
    it "responds unsuccessfully" do
      sign_in nil
      get :search
      response.should_not be_success
    end
  end
 
  describe "GET about" do
   it "response should be success" do
      sign_in
      get :about
      response.should be_success
    end
  end

  describe "GET help" do
   it "response should be success" do
      sign_in
      get :help
      response.should be_success
    end
  end

  describe "GET howto" do
   it "response should be success" do
      sign_in
      get :howto
      response.should be_success
    end
  end

  describe "GET contact" do
   it "response should be success" do
      sign_in
      get :contact
      response.should be_success
    end
  end

  describe "GET termsandconditions" do
   it "response should be success" do
      sign_in
      get :termsandconditions
      response.should be_success
    end
  end

end
