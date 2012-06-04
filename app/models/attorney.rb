class Attorney < ActiveRecord::Base
  
  attr_accessible :password, :password_confirmation
   
  # require password of at least 6 characters
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # Add methods to set and authenticate against a BCrypt password. 
  has_secure_password
  


  has_one :personal_record

  has_one :professional_record
  has_many :schools, :through => :professional_record


end
