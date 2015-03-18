require 'htmlentities'

class PostsController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    @site = params[:site]
    @decoder = HTMLEntities.new
    @grouped_posts = Post.group(Post.by_site(@site).page(params[:page] || 1).per(20))
  end

  def create
    # @decoder = HTMLEntities.new
    @post = Post.fetch_and_create params[:url]
    render json: { id: @post.id }
  end

  def show
    @decoder = HTMLEntities.new
    @post = Post.find(params[:id])
  end

  def preview
    @decoder = HTMLEntities.new
    @post = Post.find(params[:id])
  end
end
