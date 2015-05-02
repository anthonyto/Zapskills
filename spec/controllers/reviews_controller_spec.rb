require "rails_helper"
require_relative "../support/controller_helpers"

RSpec.describe ReviewsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    @user1 = FactoryGirl.create :user
    sleep(1)
  end

  describe "PATCH update" do
    it "redirects to user_url" do
      sign_in @user1
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      patch :update, {user_id:@user.id, id:@review.id, review: {:description => "john.doeexample1.com"}}
      flash[:notice].should_not be_nil
      flash[:notice].should eq("Review was successfully updated.")
      response.should redirect_to(@user)
    end
    it "responds unsuccessfully" do
      sign_in nil
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      patch :update, {user_id:@user.id, id:@review.id, review: {:description => "john.doeexample1.com"}}
      response.should_not be_success
    end
  end

  describe "PUT update" do
    it "redirects to user_url" do
      sign_in @user1
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      put :update, {user_id:@user.id, id:@review.id, review: {:description => "john.doeexample1.com"}}
      flash[:notice].should_not be_nil
      flash[:notice].should eq("Review was successfully updated.")
      response.should redirect_to(@user)
    end
    it "responds unsuccessfully" do
      sign_in nil
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      put :update, {user_id:@user.id, id:@review.id, review: {:description => "john.doeexample1.com"}}
      response.should_not be_success
    end
  end

  describe "DELETE destroy" do
    it "redirects to user_url" do
      sign_in @user1
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      delete :destroy, {user_id:@user.id, id:@review.id}
      flash[:notice].should_not be_nil
      flash[:notice].should eq("Review was successfully destroyed.")
      response.should redirect_to(@user)
    end
    it "responds unsuccessfully" do
      sign_in nil
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      delete :destroy, {user_id:@user.id, id:@review.id}
      response.should_not be_success
    end
  end

  describe "POST create" do
    it "responds successfully and does not render new" do
      sign_in @user1
      @skill = FactoryGirl.create(:skill)
      @review = FactoryGirl.attributes_for(:review, skill_id:@skill.id)
      post :create, {user_id:@user.id, review:@review}
      flash[:notice].should_not be_nil
      flash[:notice].should eq("Review was successfully created.")
      response.should redirect_to(@user)
      response.should_not render_template("new")
    end
    it "responds unsuccessfully because not signed-in" do
      sign_in nil
      @user = FactoryGirl.create :user
      @review = FactoryGirl.attributes_for :review
      post :create, {user_id:@user.id, review:@review}
      response.should_not be_success
    end
  end
  describe "GET edit" do
    it "response is success" do
      sign_in @user1
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      get :edit, {user_id:@user.id, id:@review.id}
      flash[:notice].should be_nil
      response.should be_success
    end
    it "responds unsuccessfully" do
      sign_in nil
      @review = FactoryGirl.create(:review, reviewee_id: @user.id, reviewer_id:@user1.id )
      get :edit, {user_id:@user.id, id:@review.id}
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
