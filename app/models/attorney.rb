class Attorney < ActiveRecord::Base

  ACCEPTED_AND_ACTIVE = [%(status = ? AND
                          deactivated = ? AND
                          (email_verified IS NULL OR email_verified = ?)),
                          Connection::ACCEPTED, false, true]
                          
  REQUESTED_AND_ACTIVE = [%(status = ? AND
                          deactivated = ? AND
                          (email_verified IS NULL OR email_verified = ?)),
                          Connection::REQUESTED, false, true]
  
  attr_accessible  :email, :first_name, :last_name, :middle_initial,
  				         :password, :password_confirmation, 
  				         :city, :state, :country,
  				         :attorney_type,
                   :professional_record_attributes
  
  # Add methods to set and authenticate against a BCrypt password. 
  has_secure_password   

  has_many :connections
  has_many :contacts, :through => :connections,
                      :conditions => ACCEPTED_AND_ACTIVE,
                      :order => 'people.created_at DESC'

  has_many :requested_contacts, :through => :connections,
           :source => :contact,
           :conditions => REQUESTED_AND_ACTIVE


  has_many :professional_experiences, dependent: :destroy #delete with attny

  has_many :referrals, dependent: :destroy #delete referral with attny
  accepts_nested_attributes_for :referrals, allow_destroy: true
  
  has_one :professional_record
  accepts_nested_attributes_for :professional_record
  
  #callbacks
  before_save { |attorney| attorney.email = email.downcase }
  before_save :create_remember_token 

  
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

  def name
    return full_name
  end
  
  def full_name
    [first_name, middle_initial_with_period, last_name].compact.join(' ')
  end


  def middle_initial_with_period
    "#{middle_initial}." unless middle_initial.blank?
  end


  
  
  private
  
  	def create_remember_token
  		# make a custom remember token using the urlsafe_base64 method 
  		# (creates a Base64 string safe for use in URIs)
   		self.remember_token = SecureRandom.urlsafe_base64
  	end


end
