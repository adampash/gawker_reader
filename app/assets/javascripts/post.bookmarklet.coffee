 # Arguments :
 #  verb : 'GET'|'POST'
 #  target : an optional opening target (a name, or "_blank"), defaults to "_self"
post_open = (verb, url, data, target) ->
  form = document.createElement("form")
  form.action = url
  form.method = verb
  form.target = target || "_self"
  if (data)
    for key in data
      input = document.createElement("textarea")
      input.name = key
      input.value = if typeof data[key] is "object" then JSON.stringify(data[key]) else data[key]
      form.appendChild(input)
  form.style.display = 'none'
  document.body.appendChild(form)
  form.submit()

post_open "POST", "http://localhost:3000/posts", {url: window.location.href}, "_blank"
