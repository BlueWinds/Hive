Page.NextDay = class NextDay extends Page
  text: ->
    return """|| speed="slow" auto="2000" class="nextDay"
      <h2>#{g.date}</h2>
      <h3>#{g.location.name}</h3>
    """
  apply: ->
    g.day++
    for event in Game.passDay
      event()
    super()
