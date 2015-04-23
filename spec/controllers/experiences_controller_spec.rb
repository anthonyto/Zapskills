require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe ExperiencesController, :type => :controller do

#  def create
#    @experience = Experience.new(experience_params)
#    @experience.update_attributes(user: current_user)
#    if @experience.save
#      redirect_to current_user
#    else
#      render :new
#    end
#  end
#  def update
#    if @experience.update(experience_params)
#      redirect_to current_user, notice: 'Skill was successfully updated.'
#    else
#      render :edit
#    end
#  end
  describe "POST create" do
    it "experience created" do
      @user = FactoryGirl.create :user
      sign_in @user
      @experience = FactoryGirl.attributes_for :experience
      post :create, { user_id:@user.id, experience: @experience}
      flash[:notice].should be_nil
      response.should render_template("new")
      response.should redirect_to(users_url)
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      @experience = FactoryGirl.attributes_for :experience
      post :create, { user_id:@user.id, experience: @experience}
      response.should_not be_success
    end
  end
  describe "PATCH update" do
    it "experience updated" do
      @user = FactoryGirl.create :user
      sign_in @user
      @experience = FactoryGirl.create :experience
      patch :update, {user_id:@user.id, id:@experience.id, experience: {:start_date => "2000-12-01"}}
      flash[:notice].should eq("Skill was successfully updated.")
      response.should redirect_to(current_user)
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      @experience = FactoryGirl.create :experience
      patch :update, {user_id:@user.id, id:@experience.id}, experience: {:start_date => "2000-12-01"}
      response.should_not be_success
    end
  end
  describe "DELETE destroy" do
    it "skill destroyed" do
      @user = FactoryGirl.create :user
      sign_in @user
      @experience = FactoryGirl.create :experience
      delete :destroy, {user_id:@user.id, id:@experience.id}
      flash[:notice].should eq("Skill was successfully destroyed.")
    end
    it "responds unsuccessfully" do
      sign_in nil
      @user = FactoryGirl.create :user
      @experience = FactoryGirl.create :experience
      delete :destroy, {user_id:@user.id, id:@experience.id}
      response.should_not be_success
    end
  end
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
