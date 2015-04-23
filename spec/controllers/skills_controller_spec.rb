require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe SkillsController, :type => :controller do
  describe "GET edit" do
    it "response is success" do
      @user = FactoryGirl.create :user
      sign_in @user
      @skill = FactoryGirl.create :skill
      get :edit, id:@skill.id
      flash[:notice].should be_nil
      response.should be_success
    end
    it "responds unsuccessfully" do
      sign_in nil
      @skill = FactoryGirl.create :skill
      get :edit, id:@skill.id
      response.should_not be_success
    end
  end

  describe "PATCH update" do
    it "redirects to sill_url" do
      @user = FactoryGirl.create :user
      sign_in @user
      @skill = FactoryGirl.create :skill
      patch :update, id:@skill.id, skill: {:name => "Cook"}
      flash[:notice].should_not be_nil
      flash[:notice].should eq("Skill was successfully updated.")
      response.should redirect_to(skill_path(assigns(:skill)))
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      @skill = FactoryGirl.create :skill
      delete :destroy, id:@skill.id
      response.should_not be_success
    end
  end
  
  describe "DELETE destroy" do
    it "redirects to users_url" do
      @user = FactoryGirl.create :user
      sign_in
      @skill = FactoryGirl.create :skill
      delete :destroy, id:@skill.id
      flash[:notice].should_not be_nil
      flash[:notice].should eq("Skill was successfully destroyed.")
      response.should redirect_to(skills_url)
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      delete :destroy, id:@user.id
      response.should_not be_success
    end
  end


  describe "GET new" do
#TODO: undefined method experiences
=begin
    it "responds successfully" do
      @user = FactoryGirl.attributes_for :user_with_experience
      puts @user
      sign_in @user
      get :new
      flash[:notice].should be_nil
      response.should be_success
      response.should have_http_status(200)
      response.should render_template("new")
    end
=end
    it "responds unsuccessfully" do
      sign_in nil
      get :new
      response.should_not be_success
    end
  end

  describe "POST create" do
#TODO
#    it "responds successfully and does not render new" do
#      @user = FactoryGirl.attributes_for :user
#      sign_in @user
#      @skill = FactoryGirl.create :skill
#      puts @user
#      puts @skill
#      post :create, skill:@skill
#      flash[:notice].should_not be_nil
#      flash[:notice].should eq("Skill was successfully created.")
#      response.should redirect_to(user_path(assigns(:user)))
#      response.should_not render_template("new")
#    end
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
      @skill = FactoryGirl.create :skill
      post :create, skill:@skill
      response.should_not be_success
    end
  end
end
