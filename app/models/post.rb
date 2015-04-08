# require 'kinja'
require 'digest/md5'

class Post < ActiveRecord::Base
  validates :kinja_id, uniqueness: true
  has_many :comments
  belongs_to :user

  def self.fetch_and_create(url, user)
    kinja = Kinja::Client.new
    response = kinja.get_post(url)
    post = create_from_json(response["data"], user) unless response["data"].nil?
    post = Post.find_by(url: response["data"]["permalink"]) if post.id.nil?
    post
  end

  def self.create_from_json(params, user)
    text = params["display"]
    post = create(
      {
        author: params["author"]["displayName"],
        kinja_id: params["id"],
        text: text,
        headline: params["headline"],
        publish_time: milli_to_date(params["publishTimeMillis"]),
        unique_hash: generate_hash(text),
        url: params["permalink"],
        big_image: params["facebookImage"],
        small_image: params["leftOfHeadline"],
        data: params,
        domain: get_domain(params["permalink"]),
        user_id: user.id
      }
    )
  end

  def self.group(posts)
    posts.group_by { |post| post.month_and_year }
  end

  def self.by_site(site)
    site += ".com" unless site.match (/\.com$/)
    where(domain: site).order('publish_time DESC')
  end

  def self.in_month(month, site)
    time = DateTime.strptime(month, "%B %Y")
    by_site(site).where(publish_time: time..time.end_of_month)
  end

  def self.next(seconds_since_epoch)
    time = DateTime.strptime(seconds_since_epoch.to_s, "%s")
    where('publish_time < ?', time).first
  end

  def self.prev(seconds_since_epoch)
    time = DateTime.strptime(seconds_since_epoch.to_s, "%s")
    # require 'pry'; binding.pry
    where('publish_time > ?', time).order('publish_time ASC').first
  end

  def month_and_year
    publish_time.strftime("%B %Y")
  end

  def owner_comments
    comments.where(comment_type: 'owner')
  end

  def owner_comment
    owner_comment = comments.where(comment_type: 'owner').order("updated_at DESC")
    owner_comment.empty? ? nil : owner_comment.first
  end

  def politburo_comments
    comments.where(comment_type: 'politburo')
  end

  def pinned_comments
    comments.where(pinned: true)
  end

  def author_name
    data["byline"].empty? ? author : data["byline"]
  end

  def preview_image
    small_image.nil? ? "" : small_image["src"]
  end

  def big_image_url
    big_image.nil? ? "" : big_image["uri"]
  end

  def excerpt
    data["excerpt"]
  end

  def site_name
    domain.gsub!('.com', '')
  end

  private
  def self.milli_to_date(milliseconds)
    DateTime.strptime(milliseconds.to_s, '%Q')
  end
  def self.generate_hash(text)
    Digest::MD5.hexdigest text
  end

  def self.get_domain(link)
    link.match(/\.?(\w+\.com)/)[1]
  end
end
