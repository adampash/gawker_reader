module PostsHelper
  def site_header(site_name)
    name = site_name.nil? ? "The Gawker Reader" : site_name.upcase
    url = site_name.nil? ? dashboard_path : "/#{site_name}"
    raw "<h1 class=\"site\">#{ link_to name, url }</h1>"
  end

  def timestamp(time, opts={})
    opts[:short] = opts[:short] || false
    strf = "%-m.%-d.%Y"
    unless opts[:short]
      strf = "#{strf} %-l:%M%P"
    end
    raw "<span class=\"timestamp\">#{time.in_time_zone("Eastern Time (US & Canada)").strftime(strf)}</span>"
  end
end
