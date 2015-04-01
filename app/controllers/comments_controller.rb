class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_politburo, only: :pin

  def create
    post = Post.find(params[:post_id])
    if current_user.owns_this_site(post.domain)
      user = post.user
    else
      user = current_user
    end
    @comment = Comment.find_or_create_from_params params[:text], user, post, current_user
    render json: {success: true}.to_json
  end

  def pin
    @comment = Comment.find(params[:id])
    pin = params[:value] != 'true'
    @comment.update_attributes pinned: pin
    render json: {success: true, pinned: pin}
  end
end
