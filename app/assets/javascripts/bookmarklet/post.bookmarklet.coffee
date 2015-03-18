dev = true
post_url =
  if dev
    "http://localhost:3000/posts"
  else
    "https://gawker-reader.herokuapp.com/posts"

$.ajax
  method: "POST"
  url: post_url
  data:
    url: window.location.href
  success: (result) ->
    link = "#{post_url}/preview/#{result.id}"
    window.open(link, 'share', 'height=320, width=640, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no')
