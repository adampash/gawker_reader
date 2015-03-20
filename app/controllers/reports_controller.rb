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
    @reports = Report.by_site(@site).published.page(params[:page] || 1).per(20)
    # @month = params[:month]
    # @decoder = HTMLEntities.new
    # @grouped_posts = Post.group(Post.by_site(@site).page(params[:page] || 1).per(20))
  end

  def build
    @report = Report.find_by(name: params[:month], domain: "#{params[:site]}.com")
    if @report.nil?
      @report = Report.create_from_params(params, current_user)
    end
    @decoder = HTMLEntities.new
    @posts = @report.posts
  end

  def publish
    report = Report.find(params[:id])
    publish = params[:value] != 'true'
    report.update_attributes(published: publish)
    render json: {success: true, published: publish}
  end

  def comment
    @report = Report.find params[:report_id]
    @report.summary = params[:text]
    @report.save
    render json: {success: true}
  end

  def create
    @report = Report.create_from_params(params)
  end

  def show
    @report = Report.find_by(name: params[:month], domain: "#{params[:site]}.com")
    redirect_to site_path(params[:site]) unless @report.published or current_user.politburo
    @decoder = HTMLEntities.new
    @posts = @report.posts
  end

end
