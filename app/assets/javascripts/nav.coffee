ready = ->
  $('nav .menu').on 'click', ->
    $('nav .dropdown').toggle()

$(document).ready(ready)
$(document).on('page:load', ready)
