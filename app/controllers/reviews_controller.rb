class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def new
    @review = Review.new
    @skills = @user.skills
  end
  
  def create
    @skills = @user.skills
    @review = Review.new(review_params)
    @review.reviewer_id = current_user.id
    @review.reviewee_id = @user.id

    if @review.save
      redirect_to @user, notice: 'Review was successfully created.'
    else
       render:new
    end
  end

  def edit
    @skills = @user.skills
  end

  def update
    @skills = @user.skills
    if @review.update(review_params)
      redirect_to @user, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to @user, notice: 'Review was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:reviewer, :reviewee, :skill_id, :stars, :body)
    end
end