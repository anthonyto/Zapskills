class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  # can't believe this worked lol
  after_action(only: [:create, :update, :destroy]) { |c| c.send(:update_rating, @user) }

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
       render :new
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
  
    def update_rating(user)
      rating = 0.0
      # get the sum of all ratings for the user
      user.reviews.each do |review|
        rating += review.stars
      end
      # get the average and round to nearest 0.5
      if rating != 0
        rating = round(rating/user.reviews.count)
      end
      user.update_attributes(rating: rating)
    end
  
    def round(num)
      (num*2).round / 2.0
    end
  
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