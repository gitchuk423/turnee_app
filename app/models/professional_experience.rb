class ProfessionalExperience < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :position, :current,
                  :city, :state, :country
  
  # always get most recent first
  default_scope :order => 'end_date DESC'
  
  belongs_to :attorney
  
  def location
    [city, state, country].compact.join(', ')
  end
end
