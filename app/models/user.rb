class User < ActiveRecord::Base
  has_many :experiences
  has_many :skills, :through => :experiences
end
