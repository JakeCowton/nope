class Profile < ApplicationRecord

  has_many :messages, -> { order(created_at: :desc) }, dependent: :destroy
  belongs_to :user
  
  before_create :insert_dummy_email
  after_create :generate_email

  has_secure_token :secure_token



  def generate_email
    self.email_address = "#{self.secure_token}@faircustodian.com".downcase
  end

  def insert_dummy_email
    self.email_address = "example@faircustodian.com"
  end

end
