class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_politburo, only: :pin

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.find_or_create_from_params params[:text], current_user, post
    render json: {success: true}.to_json
  end

  def pin
    @comment = Comment.find(params[:id])
    pin = params[:value] != 'true'
    @comment.update_attributes pinned: pin
    render json: {success: true, pinned: pin}
  end
end
