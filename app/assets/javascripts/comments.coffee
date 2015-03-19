# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.floating_comments button').on 'click', ->
    comment = $('.floating_comments textarea').val()
    $.ajax
      method: "POST"
      url: "/comments"
      data:
        text: comment
        post_id: $(@).data('post-id')
      success: (result) ->
        debugger


  $('.notes button.cancel').on 'click', ->
    $.ajax
      method: "DELETE"
      url: "/posts/#{$('.save').data('post-id')}"
      success: (result) ->
        window.close()

  $('.notes button.save').on 'click', ->
    comment = $('.notes textarea').val()
    $.ajax
      method: "POST"
      url: "/comments"
      data:
        text: comment
        post_id: $(@).data('post-id')
      success: (result) ->
        window.close()


$(document).ready(ready)
$(document).on('page:load', ready)
