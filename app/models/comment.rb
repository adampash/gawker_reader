class Comment < ActiveRecord::Base
  belongs_to :user

  def self.find_or_create_from_params(text, user, post)
    comment = post_comment_for_user(post.id, user.id)
    if comment.nil?
      comment_type = "normal"
      comment_type = "owner" if user.id == post.user.id #and !user.politburo
      comment = create(
        text: text,
        user_id: user.id,
        post_id: post.id,
        comment_type: comment_type
      )
    else
      comment.update_attributes(text: text)
    end
    comment
  end

  def self.post_comment_for_user(post_id, user_id)
    find_by(user_id: user_id, post_id: post_id)
  end

end
