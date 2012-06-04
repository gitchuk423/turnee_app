class Referral < ActiveRecord::Base
 
  attr_accessible :client_id, :private_comments, 
                  :public_comments, :referred_from_attorney_id, 
                  :referred_to_attorney_id, :status

  
  validates :status, :inclusion => {in: (1..4), 
    message: "%{value} is not a valid status"}

  def status_string
    str = "undefined"

    case self.status
      when 1 then str =  "created"
      when 2 then str =  "sent"
      when 3 then str =  "accepted"
      when 4 then str =  "rejected"
    end

    return str
  end




end
