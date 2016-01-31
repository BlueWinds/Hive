Game::atSea = -> g.queue[g.queue.length - 1] instanceof Page.SailDay

Page.SetSail = class SetSail extends Page
  conditions:
    port: '|location'
  text: ->
    content = $('#content')
    x = (@port.location[0] - content.width() / 2)
    y = (@port.location[1] - content.height() / 2)

    locations = for key of g.map.HolidayInn.destinations
      g.map[key].renderBlock(key, 0)

    page = $.render """|| speed="slow" class="screen set-sail"
      <form><div class="bg"></div>#{locations.join('').replace(/\n/g, '')}</form>
    """
    $('.bg', page).css('background-image', 'url("game/images/' + g.mapImage + '.jpg")')

    # Triggering mousemove with touchmove so that dragscroll will work on touchscreen devices
    page.dragScroll({top: 0, bottom: 1000, left: 0, right: 1500})

    setTimeout(->
      page.scrollLeft(x)
      page.scrollTop(y)
    , 1)
    $('.location', page).click (e)->
      e.preventDefault()
      key = $(@).attr 'data-key'
      if key
        g.location = g.map[key]
      g.queue.push new Page.Port
      Game.gotoPage()
      return false

    return page

  next: false
