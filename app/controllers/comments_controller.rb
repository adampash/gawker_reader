class CommentsController < ApplicationController
  def create
    @comment = Comment.find_or_create_from_params params, current_user
    render json: {success: true}.to_json
  end
end
