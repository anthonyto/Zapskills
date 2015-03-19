class Review < ActiveRecord::Base
  has_one :reviewer, class_name: 'User'
  has_one :reviewee, class_name: 'User'
  belongs_to :appointment
end
