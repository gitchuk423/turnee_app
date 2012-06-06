class Attorney < ActiveRecord::Base
  
  attr_accessible  :email,
  				   :password, :password_confirmation,
                   :personal_record_attributes, :professional_record_attributes
  
  # Add methods to set and authenticate against a BCrypt password. 
  has_secure_password   

  has_one :personal_record
  has_one :professional_record
  accepts_nested_attributes_for :personal_record, :professional_record
  
  
  # validations
  #		check email format, must be present and in format XXX@XXX.XXX	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                                  uniqueness: { case_sensitive: false }
  # 	require password of at least 6 characters
  # 	no presence: true because blank password checked by password_digest
  #		hacked config/locales/en.yml to rename password_digest to support error message
  validates :password, length: { minimum: 6 } 
  validates :password_confirmation, presence: true

  
  #callbacks
  before_save { |user| user.email = email.downcase }





  def name
    #return "#{self.personal_record.first_name} #{self.personal_record.last_name}"     
  	self.email
  end


end
