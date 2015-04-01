class Report < ActiveRecord::Base

  def self.create_from_params(params, user)
    create(
      name: params[:month],
      domain: "#{params[:site]}.com",
      user_id: user.id
    )
  end

  def self.by_site(site)
    where(domain: "#{site}.com").order('created_at DESC')
  end

  def self.published
    where(published: true)
  end

  def posts
    Post.in_month(name, domain).reverse
  end

end
