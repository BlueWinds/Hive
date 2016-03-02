cumCost = (c)-> Object.keys(c).length * 2

progress = (c)-> Object.keys(c).length
progressNeeded = 50

add class SpawningPit extends RoomJob
  label: "Spawning Pit"
  size: 'large'
  conditions:
    '|tentaclesReady': is: true
  effects:
    depravity: -300
    milk: -50
    women: -6
    virgins: -3
  text: ->"""Summoning tentacles from the netherworld temporarily is fun, but real live monsters take a great deal of effort. Now that I've done it once, I can grow more."""

add class SpawningPit extends Page
  text: -> """|| bg="SpawningPit/4"
    -- The pregnancy of tentacle monsters is surprisingly quick - they'll be ready to give birth and be impregnated again in only a few days.`
  """
  apply: ->
    super()
    g.tentaclesReady = false

Game::tentacleProgress = 0
Game::tentaclesReady = false

matches =
  isnt: [Person.DarkLady, Person.Liana]
  optional: true


add class SpawningPit extends Job
  label: "Spawning Pit"
  text: ->
    p = if g.tentaclesReady
      "I already have enough eggs to construct a new hive. I should do that."
    else
      "#{g.tentacleProgress} out of #{progressNeeded} eggs, +#{progress @context}"

    """Here I can spawn additional tentacle monsters for use in other locations.

    #{p}
    <span class="cum">-#{cumCost @context}</span>
    <span class="lust">+1 max</span>, <span class="intelligence">-1 max</span>, <span class="strength">-1 max</span>"""
  people:
    worker1:
      isnt: [Person.DarkLady, Person.Liana]
    worker2: matches
    worker3: matches
    worker4: matches
    worker5: matches
    worker6: matches
    worker7: matches
    worker8: matches
    worker9: matches
    worker0: matches
  type: 'boring'

Job.SpawningPit::next = add class SpawningPitDaily extends Page
  conditions:
    worker1: {}
    worker2: {}
    worker3: {}
    worker4: {}
    worker5: {}
    worker6: {}
    worker7: {}
    worker8: {}
    worker9: {}
    worker0: {}
  text: ->
    if $('page').length and (Math.random() < 0.5 or g.events.SpawningPitDaily?[0] is g.day) then return false
    c = [
      """|| bg="SpawningPit/1"
        -- Monsters take good care of their pregnant mothers. She's not going anywhere, and she'll get to keep orgasming all the way up until the birth."""
      """|| bg="SpawningPit/2"
        -- Don't be sad, girl. You may be nothing more than a soon-to-be mindless womb, good for nothing except your quivering cunt, but at least there's one part of you that isn't trash!"""
      """|| bg="SpawningPit/3"
        -- Ecstasy, imprisonment, pregnancy. The joys of motherhood."""
      """|| bg="SpawningPit/4"
        -- Baby tentacles grow stong and virile based on their mother's orgasms, both count and intensity - and cutting off any stimulation besides the pleasure of their fuckholes increases both factors considerably."""
      """|| bg="SpawningPit/5"
        -- For best results, keep womb freshly doused in cum every 4-6 hours. If orgasms persist longer than 10 minutes, consult with your Dark Lady, as she would like to watch."""
      """|| bg="SpawningPit/6"
        -- ` Yeah, just hanging out, unwinding a bit after a tough day. What're you up to? ... Nah, maybe another day, I feel like keeping it in... I mean staying in tonight.`"""
    ]

    p = if g.tentaclesReady
      'Ready to construct new building'
    else
      (g.tentacleProgress + progress @) + " out of " +  progressNeeded + " eggs"

    """|| class="jobStart" auto="1800"
        <h4>Spawning Pit</h4>

      #{Math.choice c}
        <em><span class="lust">+1 max</span>, <span class="intelligence">-1 max</span>, <span class="strength">-1 max</span>
        <span class="cum">-#{cumCost @}</span>, #{p}</em>
    """
  apply: ->
    super()
    for l, worker of @context
      worker.max.strength = Math.max(0, worker.max.strength - 1)
      worker.max.intelligence = Math.max(0, worker.max.intelligence - 1)
      worker.max.lust = Math.min(100, worker.max.lust + 1)
      worker.add 'strength', 0
      worker.add 'intelligence', 0
      worker.add 'lust', 0
    g.applyEffects {cum: cumCost(@context)}

    g.tentacleProgress += progress(@context)
    if g.tentacleProgress >= progressNeeded
      g.tentacleProgress = 0
      g.tentaclesReady = true
