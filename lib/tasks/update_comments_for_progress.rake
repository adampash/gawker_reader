desc "Update comments after progress additions"

task :progress_updates => :environment do
  puts "Updating comments"

  Comment.all.each do |c|
    p = c.post
    next if p.nil?
    c.site = p.site_name
    c.story_date = p.publish_time
    c.save
  end

  puts "Done"
end
