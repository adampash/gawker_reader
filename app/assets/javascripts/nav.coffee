didScroll = null
lastScrollTop = 0
delta = 5
navbarHeight = $('header').outerHeight()
#  on scroll, let the interval function know the user has scrolled
$(window).scroll (event) ->
  didScroll = true

#  run hasScrolled() and reset didScroll status
setInterval ->
  if (didScroll)
    hasScrolled()
    didScroll = false

, 250

hasScrolled = ->
  st = $(@).scrollTop()
  # Make sure they scroll more than delta
  return if(Math.abs(lastScrollTop - st) <= delta)
  # If they scrolled down and are past the navbar, add class .nav-up.
  # This is necessary so you never see what is "behind" the navbar.
  if (st > lastScrollTop && st > navbarHeight)
    # Scroll Down
    $('header').removeClass('nav-down').addClass('nav-up')
  else
    # Scroll Up
    if(st + $(window).height() < $(document).height())
        $('header').removeClass('nav-up').addClass('nav-down')
        if $('body').hasClass('show posts')
          if $('h2.headline').visible()
            $('header .title').fadeOut()
          else
            $('header .title').text($('h2.headline.full').text()).show()
  lastScrollTop = st

ready = ->
  $('header .menu').on 'click', ->
    $('header .dropdown').toggle()
    false

  $(document).on 'click', ->
    target_class = event.target.className
    unless target_class is "fa fa-bars fa-lg menu"
      closest = $(event.target).closest('.dropdown')
      if closest.length is 0
        $('header .dropdown').hide()


$(document).ready(ready)
$(document).on('page:load', ready)
