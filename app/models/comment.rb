class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def self.find_or_create_from_params(text, user, post)
    comment = post_comment_for_user(post.id, user.id)
    if comment.nil?
      comment_type = "politburo" if user.politburo
      comment_type = "owner" if user.owns_this_site(post.domain) and !user.politburo
      comment = create(
        text: text,
        user_id: user.id,
        post_id: post.id,
        site: post.site_name,
        story_date: post.publish_time,
        comment_type: comment_type,
      )
    else
      comment.update_attributes(text: text)
    end
    comment
  end

  def self.post_comment_for_user(post_id, user_id)
    find_by(user_id: user_id, post_id: post_id)
  end

  def self.by_site(site)
    where(site: site)
  end

  def self.in_month(month, site, user_id)
    time = DateTime.strptime(month, "%B %Y")
    by_site(site).where(story_date: time..time.end_of_month).where(user_id: user_id)
  end

end
