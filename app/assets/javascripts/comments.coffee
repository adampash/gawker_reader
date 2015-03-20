# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.floating_comments button, .preview button.save, .overview button.save').on 'click', ->
    comment = $(@).parent('.floating_comments, .preview, .overview').find('textarea').val()
    post_id = $(@).data('post-id')
    if post_id?
      url = "/comments"
    else
      report_id = $(@).data('report-id') 
      url = "/reports/comment"
    params =
      text: comment
      post_id: post_id
      report_id: report_id
    $.ajax
      method: "POST"
      url: url
      data: params
      success: (result) =>
        message = $(@).parent('.floating_comments, .preview, .overview').find('.message')
        message.text("Comment saved")
        $(@).hide()
        setTimeout ->
          message.text("")
        , 2000
      error: ->
        $('.floating_comments .message').text("Something went wrong saving your comment")

  $('.floating_comments textarea').on 'focus', ->
    $('.floating_comments button').show()

  $('.preview textarea, .overview textarea').on 'focus', ->
    $(@).parent('.preview, .overview').find('button.save').show()

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
