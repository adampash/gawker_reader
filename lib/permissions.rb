class Permissions
  EMAIL_RE = /@(\w+\.\w{3})/
  def self.site_owner?(user, post)
    !user.politburo and user.email.match(EMAIL_RE)[1] == post.domain
  end
end
