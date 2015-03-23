ready = ->
  twttr.widgets.load() if twttr?.widgets?

window.twttr = (((d, s, id) ->
  fjs = d.getElementsByTagName(s)[0]
  t = window.twttr || {}
  return if (d.getElementById(id))
  js = d.createElement(s)
  js.id = id
  js.src = "https://platform.twitter.com/widgets.js"
  fjs.parentNode.insertBefore(js, fjs)

  t._e = []
  t.ready = (f) ->
    t._e.push(f)

  t
)(document, "script", "twitter-wjs"))


$(document).ready(ready)
$(document).on('page:load', ready)
