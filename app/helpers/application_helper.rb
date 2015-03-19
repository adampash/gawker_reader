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
      links.push link_to raw("<li>#{site.upcase}</li>"), "/#{site}"
      if current_user.politburo
        links.push link_to raw("<li class=\"report\">Report</li>"), report_path(site)
      end
    end
    raw links.join("")
  end
end
