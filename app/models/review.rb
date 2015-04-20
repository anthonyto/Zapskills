class Review < ActiveRecord::Base
  has_one :reviewer, class_name: 'User', foreign_key: "reviewer_id"
  has_one :reviewee, class_name: 'User', foreign_key: "reviewww_id"
  belongs_to :skill
  
  validates_presence_of :stars, :body, :reviewer_id, :reviewee_id, :skill_id
end
