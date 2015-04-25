require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe UsersController, :type => :controller do
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
  
  describe "DELETE destroy" do
    it "redirects to users_url" do
      @user = FactoryGirl.create :user
      sign_in
      delete :destroy, id:@user.id
      flash[:notice].should_not be_nil
      flash[:notice].should eq("User was successfully destroyed.")
      response.should redirect_to(users_url)
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      delete :destroy, id:@user.id
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

  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in
      get :index
      flash[:notice].should be_nil
      response.should be_success
      response.should have_http_status(200)
      response.should render_template("index")
    end
    it "responds successfully with and user created" do
      sign_in
      @user1 = FactoryGirl.attributes_for :user
      post :create, user:@user1
      get :index
      assigns(:users).should_not be_empty
      response.should be_success
      response.should render_template("index")
    end
    it "responds unsuccessfully" do
      sign_in nil
      get :index
      response.should_not be_success
    end
  end

  describe "GET new" do
    it "responds successfully" do
      sign_in
      get :new
      flash[:notice].should be_nil
      response.should be_success
      response.should have_http_status(200)
      response.should render_template("new")
    end
    it "responds unsuccessfully" do
      sign_in nil
      get :new
      response.should_not be_success
    end
  end

  describe "POST create" do
    it "responds successfully and does not render new" do
      sign_in
      @user = FactoryGirl.attributes_for :user
      post :create, user:@user
      flash[:notice].should_not be_nil
      flash[:notice].should eq("User was successfully created.")
      response.should redirect_to(user_path(assigns(:user)))
      response.should_not render_template("new")
    end
#    it "should not create user and remder new" do
#      @user = FactoryGirl.attributes_for(:user, :password => 'abcdefghr')
#      sign_in @user
#      post :create, user:@user
#      response.should redirect_to(user_path(assigns(:user)))
#      response.should_not render_template("index")
#    end
    it "responds unsuccessfully because not signed-in" do
      sign_in nil
      @user = FactoryGirl.attributes_for :user
      post :create, user:@user
      response.should_not be_success
    end
  end
end
