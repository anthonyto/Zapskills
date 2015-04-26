class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  
  # validates :skill_id, uniqueness: true
  # validate :user_cannot_have_duplicate_skills, on: :create
  # validate :user_cannot_have_duplicate_skills, on: :update
  
  validates_presence_of :skill_id, :level, :start_date, :description
  
  # There is something seriously wrong with this validation. 
  def user_cannot_have_duplicate_skills
    unless user.skills.where(id: skill_id).empty?
      errors.add(:skill_id, "can't be duplicate")
    end
  end
  
end
