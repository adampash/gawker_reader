class Report < ActiveRecord::Base

  def self.create_from_params(params, user)
    create(
      name: params[:month],
      domain: "#{params[:site]}.com",
      user_id: user.id,
      token: generate_token,
    )
  end

  def self.by_site(site)
    where(domain: "#{site}.com").order('created_at DESC')
  end

  def self.published
    where(published: true)
  end

  def posts
    Post.in_month(name, domain)
  end

  def site
    domain.split('.com')[0]
  end

  def self.generate_token
    loop do
      token = SecureRandom.urlsafe_base64
      break token unless exists?(token: token)
    end
  end

end
