# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.create_post = (url) ->
  $.ajax
    method: "POST"
    url: "/posts"
    data:
      url: url
    success: (result) ->
      link = "/posts/preview/#{result.id}"
      window.open link, '_self'

