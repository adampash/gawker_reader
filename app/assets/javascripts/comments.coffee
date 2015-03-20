# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.floating_comments button, .preview button.save').on 'click', ->
    comment = $(@).parent('.floating_comments, .preview').find('textarea').val()
    $.ajax
      method: "POST"
      url: "/comments"
      data:
        text: comment
        post_id: $(@).data('post-id')
      success: (result) =>
        message = $(@).parent('.floating_comments, .preview').find('.message')
        message.text("Comment saved")
        $(@).hide()
        setTimeout ->
          message.text("")
        , 2000
      error: ->
        $('.floating_comments .message').text("Something went wrong saving your comment")

  $('.floating_comments textarea').on 'focus', ->
    $('.floating_comments button').show()

  $('.preview textarea').on 'focus', ->
    $(@).parent('.preview').find('button.save').show()

  # $('.floating_comments textarea').bind 'input propertychange', ->
  #   window.onunload = () ->
  #     alert('You are trying to leave.')
  #     return false

  #   $(window).unload () ->
  #     debugger
  #     alert("Unloading")
  #     false

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
