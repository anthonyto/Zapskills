require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe UsersController, :type => :controller do
  before :each do
    sleep(1)
  end

  describe "GET edit" do
    it "response is success" do
      @user = FactoryGirl.create :user
      sign_in @user
      get :edit, id:@user.id
      flash[:notice].should be_nil
      response.should be_success
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      get :edit, id:@user.id
      response.should_not be_success
    end
  end

  describe "PATCH update" do
    it "redirects to users_url" do
      @user = FactoryGirl.create :user
      sign_in @user
      patch :update, id:@user.id, user: {:email => "john.doe@example1.com"}
      flash[:notice].should_not be_nil
      flash[:notice].should eq("User was successfully updated.")
      response.should redirect_to(user_path(assigns(:user)))
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      patch :update, id:@user.id, user: {:email => "john.doe@example1.com"}
      response.should_not be_success
    end
  end

  describe "PUT update" do
    it "redirects to users_url" do
      @user = FactoryGirl.create :user
      sign_in @user
      put :update, id:@user.id, user: {:email => "john.doe@example1.com"}
      flash[:notice].should_not be_nil
      flash[:notice].should eq("User was successfully updated.")
      response.should redirect_to(user_path(assigns(:user)))
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      put :update, id:@user.id, user: {:email => "john.doe@example1.com"}
      response.should_not be_success
    end
  end
  
  describe "GET show" do
    it "responds successfully with an HTTP 200 status code" do
      @user = FactoryGirl.create :user
      sign_in @user
      get :show, id:@user.id
      flash[:notice].should be_nil
      response.should have_http_status(200)
      response.should render_template("show")
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      get :show, id:@user.id
      response.should_not be_success
    end
  end
end
