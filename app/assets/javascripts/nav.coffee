ready = ->
  $('nav .menu').on 'click', ->
    $('nav .dropdown').toggle()

  $(document).on 'click', ->
    target_class = event.target.className
    unless target_class is "fa fa-bars fa-lg menu"
      closest = $(event.target).closest('.dropdown')
      if closest.length is 0
        $('nav .dropdown').hide()


$(document).ready(ready)
$(document).on('page:load', ready)
