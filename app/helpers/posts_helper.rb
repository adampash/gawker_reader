module PostsHelper
  def timestamp(time, opts={})
    opts[:short] = opts[:short] || false
    strf = "%-m.%-d.%Y"
    unless opts[:short]
      strf = "#{strf} %-l:%M%P"
    end
    raw "<span class=\"timestamp\">#{time.in_time_zone("Eastern Time (US & Canada)").strftime(strf)}</span>"
  end
end
