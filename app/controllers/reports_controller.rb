class ReportsController < ApplicationController
  before_action :is_politburo, only: :politburo
  before_action :is_owner, only: :index

  def politburo
    @site = params[:site]
    @pinnable = true
    @month = params[:month]
    @decoder = HTMLEntities.new
    @grouped_posts = Post.group(Post.by_site(@site).page(params[:page] || 1).per(20))
  end

  def index
    @site = params[:site]
    @month = params[:month]
    @decoder = HTMLEntities.new
    @grouped_posts = Post.group(Post.by_site(@site).page(params[:page] || 1).per(20))
  end

end
