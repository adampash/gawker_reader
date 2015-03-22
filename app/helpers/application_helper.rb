module ApplicationHelper
  SITES = %w(
    deadspin
    gawker
    gizmodo
    io9
    jalopnik
    jezebel
    kotaku
    lifehacker
  )
  PAIRS = {
    "deadspin" => "Deadspin",
    "gawker" => "Gawker",
    "gizmodo" => "Gizmodo",
    "io9" => "io9",
    "jalopnik" => "Jalopnik",
    "jezebel" => "Jezebel",
    "kotaku" => "Kotaku",
    "lifehacker" => "Lifehacker"
  }
  def render_sites
    links = []
    SITES.each do |site|
      links.push render_site(site)
      if current_user.politburo
        links.push render_report_link(site)
      end
    end
    raw links.join("")
  end

  def render_site(site)
    link_to raw("<li>#{site.upcase}</li>"), "/#{site}"
  end

  def render_report_link(site)
    link_to raw("<li class=\"report\">Reports</li>"), report_path(site)
  end

  def cap_site(site)
    PAIRS[site]
  end

  def site_header(site_name)
    name = site_name.nil? ? "The Gawker Reader" : cap_site(site_name)
    url = site_name.nil? ? dashboard_path : "/#{site_name}"
    raw "<h1 class=\"site\">#{ link_to name, url }</h1>"
  end

end
