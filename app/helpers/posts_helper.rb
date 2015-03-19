module PostsHelper
  def site_header(site_name)
    name = site_name.nil? ? "Gawker Reader" : site_name.upcase
    url = site_name.nil? ? dashboard_path : "/#{site_name}"
    raw "<h1 class=\"site\">#{ link_to name, url }</h1>"
  end
end
