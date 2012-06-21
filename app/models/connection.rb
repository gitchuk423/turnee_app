# == Schema Information
# Schema version: 20080916002106
#
# Table name: connections
#
#  id          :integer(4)      not null, primary key
#  attorney_id   :integer(4)      
#  contact_id  :integer(4)      
#  status      :integer(4)      
#  accepted_at :datetime        
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Connection < ActiveRecord::Base
  #extend ActivityLogger

  attr_accessible :attorney, :contact, :status, :accepted_at
  
  belongs_to :attorney
  belongs_to :contact, :class_name => "Attorney", :foreign_key => "contact_id"
  has_many :activities, :foreign_key => "item_id", :dependent => :destroy,
                        :conditions => "item_type = 'Connection'"
  validates_presence_of :attorney_id, :contact_id
  
  # Status codes.
  ACCEPTED  = 0
  REQUESTED = 1
  PENDING   = 2
  
  # Accept a connection request (instance method).
  # Each connection is really two rows, so delegate this method
  # to Connection.accept to wrap the whole thing in a transaction.
  def accept
    Connection.accept(attorney_id, contact_id)
  end
  
  def breakup
    Connection.breakup(attorney_id, contact_id)
  end
  
  class << self
  
    # Return true if the attorneys are (possibly pending) connections.
    def exists?(attorney, contact)
      not conn(attorney, contact).nil?
    end
    
    alias exist? exists?
  
    # Make a pending connection request.
    def request(attorney, contact)

      if attorney == contact or Connection.exists?(attorney, contact)
        nil
      else
        transaction do
          create(:attorney => attorney, :contact => contact, :status => PENDING)
          create(:attorney => contact, :contact => attorney, :status => REQUESTED)
        end
        true
      end
    end
  
    # Accept a connection request.
    def accept(attorney, contact)
      transaction do
        accepted_at = Time.now
        accept_one_side(attorney, contact, accepted_at)
        accept_one_side(contact, attorney, accepted_at)
      end
      # Exclude the first admin to prevent everyone's feed from
      # filling up with new registrants.
      #unless [attorney, contact].include?(attorney.find_first_admin)
      #  log_activity(conn(attorney, contact))
      #end
    end
    
    def connect(attorney, contact)
      transaction do
        request(attorney, contact,)
        accept(attorney, contact)
      end
      conn(attorney, contact)
    end
  
    # Delete a connection or cancel a pending request.
    def breakup(attorney, contact)
      transaction do
        destroy(conn(attorney, contact))
        destroy(conn(contact, attorney))
      end
    end
  
    # Return a connection based on the attorney and contact.
    def conn(attorney, contact)
      find_by_attorney_id_and_contact_id(attorney, contact)
    end
    
    def accepted?(attorney, contact)
      conn(attorney, contact).status == ACCEPTED
    end
    
    def connected?(attorney, contact)
      exist?(attorney, contact) and accepted?(attorney, contact)
    end
    
    def pending?(attorney, contact)
      exist?(attorney, contact) and conn(contact,attorney).status == PENDING
    end
  end
  
  private
  
  class << self
    # Update the db with one side of an accepted connection request.
    def accept_one_side(attorney, contact, accepted_at)
      conn = conn(attorney, contact)
      conn.update_attributes!(:status => ACCEPTED,
                              :accepted_at => accepted_at)
    end
  
    def log_activity(conn)
      #activity = Activity.create!(:item => conn, :attorney => conn.attorney)
      #add_activities(:activity => activity, :attorney => conn.attorney)
      #add_activities(:activity => activity, :attorney => conn.contact)
    end
  end
end

