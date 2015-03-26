class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin
  def index
    @users = User.all.order('created_at DESC').page(params[:page] || 1)
  end

  def toggle
    user = User.find(params[:user_id])
    value = params[:value] != "true"
    user.update_attributes(params[:key] => value)
    puts "UPDATED TO #{value}"
    render json: { params[:key] => value }
  end

  protected
  def is_admin
    redirect_to dashboard_path unless current_user.admin
  end
end
