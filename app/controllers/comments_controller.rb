class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = Comment.find_or_create_from_params params[:text], current_user, post
    render json: {success: true}.to_json
  end
end
