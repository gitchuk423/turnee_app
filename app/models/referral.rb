class Referral < ActiveRecord::Base
 
  attr_accessible :client_id, :private_comments, 
                  :public_comments, 
                  :referred_to_attorney_id, :status

  belongs_to :attorney
  
  # Return most recent first by default 
  default_scope order: 'referrals.created_at DESC'
  
# Validations
  
  validates :attorney_id, presence: true
  validates :referred_to_attorney_id, presence: true
  validates :client_id, presence: true

  validate :status_is_valid, :did_not_refer_to_myself, on: :create
  
  def summary
    attny_name = Attorney.find(referred_to_attorney_id).full_name || "Unknown attorney"
    "Referral to #{attny_name}" 
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
