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

end
