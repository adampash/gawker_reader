require 'permissions'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def is_politburo
    redirect_to dashboard_path unless current_user.politburo
  end

  def owns_this_site
    site = params[:site]
    flash[:notice] = "You can only view reports for the site you edit"
    redirect_to dashboard_path unless current_user.domain == "#{site}.com" or current_user.politburo
  end

  def is_owner
    redirect_to dashboard_path unless current_user.politburo or current_user.site_owner
  end
end
