class Comment < ActiveRecord::Base
  belongs_to :user

  def self.find_or_create_from_params(params, user)
    comment = post_comment_for_user(params[:post_id], user.id)
    if comment.nil?
      comment = create(
        text: params[:text],
        user_id: user.id,
        post_id: params[:post_id],
        comment_type: 'normal'
      )
    else
      comment.update_attributes(text: params[:text])
    end
    comment
  end

  def self.post_comment_for_user(post_id, user_id)
    find_by(user_id: user_id, post_id: post_id)
  end

end
