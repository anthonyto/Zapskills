class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  geocoded_by :location
  after_validation :geocode
  
  has_many :experiences
  has_many :skills, :through => :experiences
  has_many :written_reviews, class_name: "Review", foreign_key: "reviewer_id"
  has_many :reviews, class_name: "Review", foreign_key: "reviewee_id"
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "zapskills_platypus.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  def location
    return "#{self.city}, #{self.state}, #{self.zip_code}"
  end
end
