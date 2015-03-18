module PostsHelper
  def site_header(site_name)
    raw "<h1 class=\"site\">#{ link_to site_name.upcase, "/#{site_name}" }</h1>"
  end
end
