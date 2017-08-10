cocoonMilk = -> 0.2

cocoonCum = -> 2

add class Cocoon extends RoomJob
  label: "Tentacle Cocoon"
  effects:
    milk: -30
    women: -2
  conditions:
    '|tentaclesReady': is: true
    '|events|SpawningPit': {}
  size: 'small'
  text: ->"""A couple of women permanently encased in living tentacle-shells. <span class="milk">+#{cocoonMilk()}</span>, <span class="cum">+#{cocoonCum()}</span> daily"""

add class Cocoon extends Page
  text: -> """|| bg="Cocoon/Build1"
  || bg="Cocoon/Build2"
  || bg="Cocoon/Build3"
  || bg="Cocoon/Build4"
  ||
    -- And she never saw daylight again.
  """
  apply: ->
    super()
    g.tentaclesReady = false

add class Cocoon extends Job
  label: "Cocoon"
  text: ->"""Trapped in eternal pleasure, seeing nothing but the inside of their living cocoon and smelling nothing but their own arousal. <span class="milk">+#{cocoonMilk()}</span>, <span class="cum">+#{cocoonCum()}</span> daily"""
  people: {}
  type: 'boring'

Job.Cocoon::next = add class CocoonDaily extends Page
  conditions:
    milk: fill: cocoonMilk
    cum: fill: cocoonCum
  text: ->
    if $('page').length and (Math.random() < 0.75 or g.events.CocoonDaily?[0] is g.day) then return false
    c = [
      """|| bg="Cocoon/1"
        -- Are they lucky to have a bit of bodily and sensory freedom or not? I like it at least, since with heads free they can still get embarrassed by people watching."""
      """|| bg="Cocoon/2"
        -- Underwater? Not a problem - tentacle monsters are very creative at keeping their victims alive and thrashing."""
      """|| bg="Cocoon/3"
        -- You can tell by the fact that her clothes haven't finished dissolving yet that the third woman is a new addition."""
      """|| bg="Cocoon/4"
        -- There's not always light inside, but it does turn on occasionally to let them see themselves naked, shivering with ecstasy and drenched in cum."""
    ]

    """|| class="jobStart" auto="1800"
        <h4>Tentacle Cocoon</h4>

      #{Math.choice c}
      <span class="milk">+#{cocoonMilk()}</span>, <span class="cum">+#{cocoonCum()}</span>
    """
  effects:
    milk: 'milk'
    cum: 'cum'
