class Attorney < ActiveRecord::Base
  
  attr_accessible  :email, :first_name, :last_name, :middle_initial,
  				         :password, :password_confirmation,
                   :personal_record_attributes, :professional_record_attributes
  
  # Add methods to set and authenticate against a BCrypt password. 
  has_secure_password   

  has_many :professional_experiences, dependent: :destroy #delete with attny

  has_many :referrals, dependent: :destroy #delete referral with attny
  accepts_nested_attributes_for :referrals, allow_destroy: true
  
  has_one :personal_record
  has_one :professional_record
  accepts_nested_attributes_for :personal_record, :professional_record
  
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
