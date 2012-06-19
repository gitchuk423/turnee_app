class ProfessionalExperience < ActiveRecord::Base
  
  #formatting methods
  include DateHelper 
  
  attr_accessible :end_date, :name, :start_date, :position, :current,
                  :city, :state, :country
  
  # always get most recent first
  default_scope order: 'end_date DESC'
  
  belongs_to :attorney
  
  
  # Validations
  validates :name, presence: true
  validates :position, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true, on: :save
  
  validate :check_end_date
  
  def default_end_date
    {year: Time.now.year, month: Time.now.month, day: Time.now.day}
  end
  
  def location
    [city, state, country].compact.join(', ')
  end
  


  private  
    
      def check_end_date
      
        # Set to current date if not set  
        self.end_date ||= Time.now.to_date
      
        if (self.start_date > self.end_date)
          errors.add(:start_date, "must be earlier than end date")
        end
      end

end
