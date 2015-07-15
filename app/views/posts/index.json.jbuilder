json.months @grouped_posts do |group|
  @posts = group[1..-1].flatten
  json.set! group[0] do
    json.array! @posts do |post|
      json.partial! 'posts/post_preview', post: post
    end
  end
end
