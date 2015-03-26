require 'slack_notifier'

class User < ActiveRecord::Base
  WHITELISTED_EMAILS = /^\w.*@(gawker|deadspin|jezebel|kotaku|lifehacker|jalopnik|io9|gizmodo)\.com$/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.whitelisted?(email)
    !email.match(WHITELISTED_EMAILS).nil?
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data["name"],
         email: data["email"],
         avatar: data["image"],
         password: Devise.friendly_token[0,20]
      )
      new_user_notification(user)
    end
    user
  end

  def self.new_user_notification(user)
    SlackNotifier.notify("#{user.name} just signed up http://reader.gawker-labs.com/admin") if ENV["SLACK_TOKEN"]
  end

  def first_name
    name.split(" ")[0]
  end

  def domain
    email.match(/@(\w+\.com)/)[1]
  end

  def owns_this_site(site)
    site_owner and domain == site
  end

end
