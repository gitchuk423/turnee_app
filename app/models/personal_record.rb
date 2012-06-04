class PersonalRecord < ActiveRecord::Base
  attr_accessible :attorney_id, :email, :first_name, :last_name
  belongs_to :attorney

  #callbacks
  before_save { |user| user.email = email.downcase }

  #validations
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                                  uniqueness: { case_sensitive: false }

end
