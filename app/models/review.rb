class Review < ActiveRecord::Base
  has_one :reviewer, class_name: 'User', foreign_key: "reviewer_id"
  has_one :reviewee, class_name: 'User', foreign_key: "reviewee_id"
  belongs_to :skill
  
  validate :user_cannot_write_review_about_themselves, on: :create
  
  validates_presence_of :stars, :body, :reviewer_id, :reviewee_id, :skill_id
  
  def user_cannot_write_review_about_themselves
    if reviewer_id == reviewee_id
      errors.add(:reviewer, "cannot write a review about yourself")
    end
  end
end

