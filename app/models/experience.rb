class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  
  validates_presence_of :skill_id, :level, :description
  
  enum level: [:Beginner, :Intermediate, :Advanced, :Expert, :Guru]
  
end
