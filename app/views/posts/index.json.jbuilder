json.months @grouped_posts do |group|
  json.month group[0]
  @posts = group[1..-1].flatten
  json.posts do
    json.array! @posts do |post|
      json.partial! 'posts/post_preview', post: post
    end
  end
end
