class Client < ActiveRecord::Base

  attr_accessible :referral_id, :first_name, :last_name, :email
   
  # validations
  #		check email format, must be present and in format XXX@XXX.XXX	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  
                
  def full_name
    [first_name, last_name].compact.join(' ')
  end


end
