class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  
  validates :skill_id, uniqueness: true
  validates_presence_of :skill_id, :level, :start_date, :description
  
end
