effect = ->
  e = 2
  if g.events.SexyGym then e += 1
  return e

add class Gym extends RoomJob
  label: "Gym"
  size: 'medium'
  effects:
    depravity: -150
    men: -2
    women: -1
  text: ->"""People can train their <span class="strength">strength</span> here. So far I've relied on my magic to get my way, but it's somewhat boring having to hunt every new slave myself."""

add class Gym extends Page
  text: -> """|| bg="Gym/Treadmills"
    -- While I myself am of course eternally perfect, I can hardly expect the same of my merely mortal servants.
    --> The postal system in this kingdom is amazing. I have only to tell my servants to spend their money, and like magic the appropriate items show up on my doorstop.
  """

add class Gym extends Job
  label: "Gym"
  text: -> """Running around, working out and generally getting sweaty and exhausted has some benefits for humans.

  <em class="strength">+#{effect()} Strength</em>"""
  people:
    worker: matches: (w)-> w.strength < w.max.strength
  next: Page.firstMatch
  @next: []
  type: 'boring'

Job.Gym.next.push add class GymDarkLady extends Page
  conditions:
    '|last|worker': is: Person.DarkLady
  text: ->"""|| class="jobStart" auto="1800"
    <h4>Gym</h4>
  ||
    -- I'm not going to do anything so undignified as sweat. Fuck that.
    -- I sit on the ground, cross my legs, and sink into myself. Most people wouldn't expect to find the Dark Lady of lust and domination to meditate, but... most people don't really know me very well.
  || bg="Gym/Meditate"
    --> I am not human. I am not mortal. Being dead for how many thousands of years has weakened me, but not in the ways that matter. From the eternal font of power that is my soul, I draw forth magic and restore some of my body's might.
    --> <em class="strength">+#{effect()} Strength</em>"""
  apply: ->
    super()
    D.add('strength', effect())

Job.Gym.next.push add class GymDaily extends Page
  conditions:
    worker: {}
  text: ->
    if Math.random() < 0.75 or g.events.GymDaily?[0] is g.day then return false
    l = [
      """|| bg="Gym/Treadmills"
        --""",
      """|| bg="Gym/Bike1"
        --""",
      """|| bg="Gym/Bike2"
        --""",
    ]
    if g.events.SexyGym
      l.push """|| bg="Gym/Nude1"
        -- These girls are faster than they look. Catching them is a hard prize to earn!"""
      l.push """|| bg="Gym/Nude2"
        --"""

    return """|| class="jobStart" auto="1800"
      <h4>Gym</h4>
    #{Math.choice l}
      <em class="strength">+#{effect()} Strength</em>"""
  apply: ->
    super()
    @context.worker.add('strength', effect())

add class SexyGym extends ResearchJob
  label: "Nude Gym"
  progress: 500
  text: ->"""<span class="strength">+1 Strength</span> when training in the gym.
  <br>Really, clothes just get in the way when you're exercising."""

add class SexyGym extends Page
  text: ->"""|| bg="Gym/Nude1"
    -- I've added all sorts of fun games to the gym. Catch her you get to fuck her. He catches you he fucks you. Lift ten more pounds than last week and get a blow job.
     --> Ok, not really "all sorts."
     --> Look, I'm the Dark Lady. I like to stick with what I know.
  """
