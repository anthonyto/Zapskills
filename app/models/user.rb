class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  geocoded_by :location
  after_validation :geocode
  
  has_many :experiences
  has_many :skills, :through => :experiences
  
  def complete_profile?
    self.first_name != nil &&
    self.last_name != nil &&
    self.city != nil &&
    self.state != nil &&
    self.zip_code != nil &&
    self.date_of_birth != nil
  end
  
  def location
    return "#{self.city}, #{self.state}, #{self.zip_code}"
  end
end
