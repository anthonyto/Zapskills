require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe ExperiencesController, :type => :controller do
  describe "GET edit" do
    it "response is success" do
      @user = FactoryGirl.create :user
      sign_in @user
      @experience = FactoryGirl.create :experience
      get :edit, {user_id:@user.id, id:@experience.id}
      flash[:notice].should be_nil
      response.should be_success
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      @experience = FactoryGirl.create :experience
      get :edit, {user_id:@user.id, id:@experience.id}
      response.should_not be_success
    end
  end

  describe "GET show" do
    it "responds successfully with an HTTP 200 status code" do
      @user = FactoryGirl.create :user
      sign_in @user
      @experience = FactoryGirl.create :experience
      get :show, {user_id:@user.id, id:@experience.id}
      flash[:notice].should be_nil
      response.should have_http_status(200)
      response.should render_template("show")
    end
    it "responds unsuccessfully" do
      sign_in nil
      @experience = FactoryGirl.create :experience
      @user = FactoryGirl.create :user
      get :show, {user_id:@user.id, id:@experience.id}
      response.should_not be_success
    end
  end

  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in
      @user = FactoryGirl.create :user
      get :index, user_id:@user.id
      flash[:notice].should be_nil
      response.should be_success
      response.should have_http_status(200)
      response.should render_template("index")
    end
    it "responds successfully with and user created" do
      sign_in
      @experience = FactoryGirl.create :experience
      @user = FactoryGirl.create :user
      get :index, user_id:@user.id
      assigns(:experiences).should_not be_empty
      response.should be_success
      response.should render_template("index")
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      get :index, user_id:@user.id
      response.should_not be_success
    end
  end

  describe "GET new" do
    it "responds successfully" do
      @user = FactoryGirl.create :user
      sign_in @user
      get :new, user_id:@user.id
      flash[:notice].should be_nil
      response.should be_success
      response.should have_http_status(200)
      response.should render_template("new")
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      get :new , user_id:@user.id
      response.should_not be_success
    end
  end
end
