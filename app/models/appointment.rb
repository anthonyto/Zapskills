class Appointment < ActiveRecord::Base
  has_one :tutor, class_name: "User"
  has_one :tutee, class_name: "User"
end
