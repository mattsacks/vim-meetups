# toggle nav on slide deck change
activateNav = (e, from, to) ->
    # show the nav list after the first slide
    if to is 0
        return @element.removeClass('show')
    else if from is 0
        @element.addClass('show')

    # highlight the current active slide section
    @subnavs.filter('.active').removeClass('active')

    # to - 1 represents the current index when starting from the second slide
    @subnavs.eq(to - 1).addClass('active')

    # show the talk menu in the nav on the 4th slide and hide it when complete
    # (tried making these dynamic with /^talk-/.test(..attr('id')) but deck.js is fucked)
    if to >= 3 and to < 14
        @subnav.addClass('active')
    else
        @subnav.removeClass('active')

# each time the slide deck changes
$(document).live 'deck.change', ->
    activateNav.apply(window.nav, arguments)

# extra slide keyboard shortcuts
$(document).live 'keyup', (e) ->
    numIndex = numKeys.indexOf(e.keyCode)

    # if the key is a 0-9 key, go to that slide
    if numIndex isnt -1
        $.deck('go', numIndex)
    # if the key is h, k or p, go to previous slide
    else if [72, 75, 80].indexOf(e.keyCode) isnt -1
        $.deck('prev')
    # if the key is j, l, or n then go to next slide
    else if [74, 76, 78].indexOf(e.keyCode) isnt -1
        $.deck('next')


# document.ready
$ ->
    # navigation object
    tempNav = $('#nav')
    window.nav =
        element: tempNav
        subnav:  tempNav.find('ul.subnav')
        subnavs: tempNav.find('li')

    # 0-9 keycodes
    window.numKeys = [48..57]

    window.deck =
        slides: $('.slide')
# vim:fdm=indent fdn=3 fml=3
