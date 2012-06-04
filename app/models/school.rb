class School < ActiveRecord::Base
  
  belongs_to :professional_record


  attr_accessible :attorney_id, :city, :major, :name, :professional_record_id, :state

end
