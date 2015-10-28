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

ready = ->
  $('.remove_post').on 'click', ->
    if confirm("Are you sure you want to remove this post?")
      $.ajax
        method: "DELETE"
        url: "/posts/#{$(@).data('post-id')}"
        success: (result) ->
          $("##{result.post_id}").fadeOut()
          month_count = $("##{result.month_and_year}")
          last_count = parseInt month_count.data('count')
          month_count.data('count', last_count - 1)
          month_count.text("#{month_count.data('count')} posts")
    false

  $('.lazy-image img').map((index, img) =>
    $(img).attr('src', $(img).data('asset-url'))
  )



$(document).ready(ready)
$(document).on('page:load', ready)

receiveMessage = (message) ->
  message = JSON.parse(message.data)
  if message.kinja?
    $('iframe[src="' + message.kinja.sourceUrl + '"]')
      .height(message.kinja.resizeFrame.height)

window.addEventListener("message", receiveMessage, false)
