class ChangeUserIdToReviewerAndRevieweeIdInReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :user_id, :integer
    add_column :reviews, :reviewer_id, :integer
    add_column :reviews, :reviewee_id, :integer
  end
end
