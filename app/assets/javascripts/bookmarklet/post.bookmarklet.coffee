dev = true
post_url =
  if dev
    "http://localhost:3000/posts"
  else
    "https://gawker-reader.herokuapp.com/posts"

link = "#{post_url}/submit?url=#{window.location.href}"
window.open(link, 'share', 'height=420, width=740, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no')
