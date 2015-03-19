# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  $('a.toggle').on 'click', ->
    $el = $(@)
    key = $el.data('key')
    val = $el.data('val')
    url = $el.data('url')
    $.ajax
      url: url
      method: "POST"
      data:
        key: key
        value: val
      success: (result) ->
        $el.data('val', result[key])
        if result[key]
          $el.text("Yes")
        else
          $el.text("No")

    false



$(document).ready(ready)
$(document).on('page:load', ready)
