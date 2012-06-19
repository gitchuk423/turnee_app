class Referral < ActiveRecord::Base
 
  attr_accessible :client_id, 
                  :client_first_name, :client_last_name,
                  :client_email, :client_phone,
                  :private_comments, :public_comments, 
                  :referred_to_attorney_id, :status


  belongs_to :attorney
  
  # Return most recent first by default 
  default_scope order: 'referrals.created_at DESC'
  
# Validations
  
  validates :attorney_id, presence: true
  validates :referred_to_attorney_id, presence: true


  validate :status_is_valid, :did_not_refer_to_myself, on: :create
 
  # validations
  #		check email format, must be present and in format XXX@XXX.XXX	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :client_email, format: { with: VALID_EMAIL_REGEX }
  
  
  def one_line
    creation = created_at.strftime("%m/%d/%Y")

    referred_to_attorney = Attorney.find_by_id(referred_to_attorney_id).full_name
    "#{creation} : Referred #{client_full_name}"
  end
  
  def summary
    referred_to_attorney = Attorney.find_by_id(referred_to_attorney_id).full_name
    "Referred #{client_full_name} to #{referred_to_attorney}."
  end
                
  def client_full_name
    [client_first_name, client_last_name].compact.join(' ')
  end


  
private
  
    def did_not_refer_to_myself
      if (attorney_id == self.referred_to_attorney_id)
        errors.add(:referred_to_attorney_id, "Cannot refer work to oneself")
      end
    end
    
  
    def status_is_valid
      
      self.status = "created" unless !self.status.nil?
      
      # check for a user-submitted status that is not valid 
      # this is sort of a "validates_inclusion_of" for the 
      # limited types of referral status
      if (!["created", "sent", "accepted", "rejected"].include? self.status) 
          errors.add(:status, "#{self.status} is not a valid status")
      end    
    end


end
