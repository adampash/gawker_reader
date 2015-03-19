require 'htmlentities'

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :site_owner, :only => [:submit]
  protect_from_forgery :except => [:create]

  def index
    @site = params[:site]
    @owns = current_user.owns_this_site(@site)
    @decoder = HTMLEntities.new
    @grouped_posts = Post.group(Post.by_site(@site).page(params[:page] || 1).per(20))
  end

  def create
    # @decoder = HTMLEntities.new
    @post = Post.fetch_and_create params[:url], current_user
    render json: { id: @post.id }
  end

  def submit

  end

  def show
    @decoder = HTMLEntities.new
    @comment = Comment.post_comment_for_user(params[:id], current_user.id)
    @post = Post.find(params[:id])
    @site = @post.domain.gsub(".com", "")
  end

  def preview
    @decoder = HTMLEntities.new
    @post = Post.find(params[:id])
  end

  def destroy
    Post.find(params[:id]).destroy
    render json: { success: true, post_id: params[:id] }
  end

  protected
  def site_owner
    flash[:notice] = "Only site leads can submit new stories. If you're a site lead and you're getting this message, ping Adam on Slack."
    redirect_to root_path unless current_user.site_owner
  end
end
