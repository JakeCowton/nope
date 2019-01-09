class User < ApplicationRecord
  if Rails.env.production?
    # Elasticsearch-model setup
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name 'data-users'
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :profiles, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  before_validation :generate_referral_code

  after_create :generate_default_profiles, :notify_registration
  after_update :send_to_websand

  validates :referral_code, uniqueness: true
  validate :block_our_domain

  def tokens
    Doorkeeper::AccessToken.where(resource_owner_id: id).all
  end

  def send_to_websand
    response = HTTParty.post(
      'https://fair-custodian.websandhq.com/api/data/subscriber', 
      {
        'headers': {"Authorization": "Token #{ENV['WEBSAND_API_KEY']}"},
        'body': {
          "subscriber": {
            "email": email,
            "source": "beta-user",
            "subscribed_at": DateTime.now.iso8601,
            "last_seen": last_seen.iso8601
          }
        }
      }
    )
  end

  def generate_default_profiles
    categories = ['Profile #3', 'Profile #2', 'Profile #1']
    categories.each do |c|
      profile = profiles.create!(name: c)
      profile.generate_email
      profile.save
    end
  end

  def after_confirmation
    Processing::EventJob.perform_later("new user confirmed - #{email}", 'sign up', true)
  end

  def can_create_profile?
    return false if profiles.count >= max_profiles
    return true
  end

  def stripe_subscription
    return false if stripe_subscription_id.nil?
    Stripe::Subscription.retrieve(stripe_subscription_id)
  end

  def cancel_stripe_subscription
    stripe_subscription.delete
    update(stripe_subscription_id: nil)
    Processing::EventJob.perform_later("subscripton cancelled - #{email}", 'subscription', true)
  end

  def notify_registration
    Processing::EventJob.perform_later("new user registration - #{email}", 'sign up', true)
  end

  def after_database_authentication
    Processing::EventJob.perform_later("new login - #{email}", 'login', true)
  end

  def generate_referral_code
    return false unless referral_code.empty?
    code = ('a'..'z').to_a.shuffle[0,8].join
    self.referral_code = code
  end

  def referred_by
    begin
      User.find referred_by_id
    rescue ActiveRecord::RecordNotFound
      return nil
    end
  end

  def referred
    User.where(referred_by_id: id).all
  end

  def block_our_domain
    if !email.include? ENV['SEND_EMAIL_DOMAIN']
      return false
    else
      errors.add(:email, "can't be a Fair Custodian address")
    end
  end

end
