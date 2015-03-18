class PagesController < ApplicationController
  def welcome
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
    @sites = [
      "deadspin",
      "gawker",
      "gizmodo",
      "io9",
      "jalopnik",
      "jezebel",
      "kotaku",
      "lifehacker"
    ]
  end
end
