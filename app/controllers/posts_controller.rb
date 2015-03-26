class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :site_owner, :only => [:submit]
  protect_from_forgery :except => [:create]

  def index
    @site = params[:site]
    @owns = current_user.owns_this_site("#{@site}.com")
    @posts = Post.by_site(@site).page(params[:page] || 1).per(20)
    @grouped_posts = Post.group(@posts)
    @post_count = {}
    @grouped_posts.each do |group|
      @post_count[group[0]] = Post.in_month(group[0], @site).count
    end
  end

  def create
    @post = Post.fetch_and_create params[:url], current_user
    render json: { id: @post.id }
  end

  def submit

  end

  def show
    @comment = Comment.post_comment_for_user(params[:id], current_user.id)
    @post = Post.find(params[:id])
    @site = @post.domain.gsub(".com", "")
  end

  def preview
    @post = Post.find(params[:id])
  end

  def destroy
    Post.find(params[:id]).destroy
    render json: { success: true, post_id: params[:id] }
  end

  protected
  def site_owner
    flash[:notice] = "Only site leads can submit new stories. If you're a site lead and you're getting this message, ping Adam on Slack."
    # require 'pry'; binding.pry
    domain = params["url"].match(/https?:\/\/(\w+\.)?(\w+\.com)/)[2]
    redirect_to root_path unless Permissions.site_owner?(current_user, domain)
  end
end
