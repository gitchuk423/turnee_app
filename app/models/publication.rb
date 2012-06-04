class Publication < ActiveRecord::Base
  
  belongs_to :professional_record

  attr_accessible :name, :professional_record_id, :publication_date, :url

end
