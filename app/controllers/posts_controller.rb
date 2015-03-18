class PostsController < ApplicationController
  def index
    @site = params[:site]
  end

  def create
    @post = Post.fetch_and_create params[:url]
  end
end
