class ProfessionalRecord < ActiveRecord::Base
  
  belongs_to :attorney
  has_many :schools
  has_many :publications

  attr_accessible :attorney_id, :experience, :firm_name
end
