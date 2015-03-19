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
    end
    user
  end

  def first_name
    name.split(" ")[0]
  end

  def owns_this_site(site)
    site_owner and email.match(/@(\w+)\./)[1] == site
  end

end
