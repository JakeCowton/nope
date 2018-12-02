class User < ApplicationRecord
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

  after_create :send_to_websand, :generate_default_profiles

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
            "subscribed_at": DateTime.now.iso8601
          } 
        }
      })
  end

  def generate_default_profiles
    categories = ['Shopping', 'Social', 'Spam']
    categories.each do |c|
      profile = profiles.create!(name: c)
      profile.generate_email
      profile.save
    end
  end

  def after_confirmation
    if Rails.env.production?
      response = HTTParty.post(
        ENV['SLACK_WEBHOOK_URL'],
        body: {
          payload: {
            text: email
          }.to_json
        }
      )
    end
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
  end

end
