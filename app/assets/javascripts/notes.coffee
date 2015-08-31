# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $('.load_notes').each (month) ->
    $.ajax
      url: "/notes"
      method: "GET"
      data:
        month_and_year: $(@).data('month')
        site: $(@).data('site')
        editable: $(@).data('editable') is 1 ? true : false
      success: (response) =>
        $(@).val(response.text)
        $(@).html(response.text)
        evt = document.createEvent('Event')
        evt.initEvent('resize', true, false)
        $(@)[0].dispatchEvent(evt)
      error: (e) ->
        console.log 'error'
      complete: ->
        console.log 'complete'

  $('.save_note').on 'click', ->
    $(@).hide()
    textarea = $(@).prev('textarea')
    text = textarea.val()
    $.ajax
      method: "POST"
      url: "/notes"
      data:
        month_and_year: textarea.data('month')
        site: textarea.data('site')
        text: text
      success: (response) =>
        message = $(@).parent().find(".message")
        message.text("Saved notes")
        setTimeout ->
          message.text("")
        , 2000
      error: (e) ->
        message = $(@).parent().find(".message")
        message.text("Error saving note. If this keeps happening, tell Adam.")
      complete: ->
        console.log 'complete'



$(document).ready(ready)
$(document).on('page:load', ready)
