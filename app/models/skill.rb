class Skill < ActiveRecord::Base
  has_many :experiences
  has_many :users, :through => :experiences
end
