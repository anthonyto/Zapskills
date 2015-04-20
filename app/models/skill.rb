class Skill < ActiveRecord::Base
  has_many :experiences
  has_many :users, :through => :experiences
  
  validates :name, presence: true
  validates :name, uniqueness: true
end
