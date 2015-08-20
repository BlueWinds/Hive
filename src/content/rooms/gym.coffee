effect = ->
  e = 2
  if g.events.SexyGym then e += 1
  return e

Place.Rooms::jobs.gym = RoomJob.Gym = class Gym extends RoomJob
  label: "Gym"
  size: 'medium'
  effects:
    depravity: -150
    men: 2
    women: 1
  text: ->"""People can train their <span class="strength">strength</span> here. So far I've relied on my magic to get my way, but it's somewhat boring having to hunt every new slave myself."""

RoomJob.Gym::next = Page.Gym = class Gym extends Page
  text: -> """|| bg="Gym/Treadmills.jpg"
    -- While I myself am of course eternally perfect, I can hardly expect the same of my merely mortal servants.
  ||
    --> The postal system in this kingdom is amazing. I have only to tell my servants to spend their money, and like magic the appropriate items show up on my doorstop.
  """

RoomJob.Gym::room = Job.Gym = class Gym extends Job
  label: "Gym"
  text: -> """Running around, working out and generally getting sweaty and exhausted has some benefits for humans.
  <br><em class="strength">+#{effect()} Strength</em>"""
  officers:
    worker: {}
  next: Page.firstMatch
  @next: []
  type: 'boring'

Job.Gym.next.push Page.GymDarkLady = class GymDarkLady extends Page
  conditions:
    worker:
      is: Officer.DarkLady
  text: ->"""|| class="jobStart" auto="1800"
    <h4>Gym</h4>
  ||
    -- I'm not going to do anything so undignified as sweat. Fuck that.
  ||
    -- I sit on the ground, cross my legs, and sink into myself. Most people wouldn't expect to find the Dark Lady of lust and domination to meditate, but... most people don't really know me very well.
  || bg="Gym/Meditate.jpg"
    --> I am not human. I am not mortal. Being dead for how many thousands of years has weakened me, but not in the ways that matter. From the eternal font of power that is my soul, I draw forth magic and restore some of my body's might.
  ||
    --> <em class="strength">+#{effect()} Strength</em>"""
  apply: ->
    super()
    @context.worker.add('strength', effect())

Job.Gym.next.push Page.GymDaily = class GymDaily extends Page
  conditions:
    worker: {}
  text: ->
    if Math.random() < 0.75 or g.events.GymDaily?[0] is g.day then return false
    l = [
      """|| bg="Gym/Treadmills.jpg"
        -- """,
      """|| bg="Gym/Bike1.jpg"
        -- """,
      """|| bg="Gym/Bike2.jpg"
        -- """,
    ]
    if g.events.SexyGym
      l.push """|| bg="Gym/Nude1.jpg"
        -- These girls are faster than they look. Catching them is a hard prize to earn!"""
      l.push """|| bg="Gym/Nude2.jpg"
        --"""

    return """|| class="jobStart" auto="1800"
      <h4>Gym</h4>
    #{Math.choice l}
      <em class="strength">+#{effect()} Strength</em>"""
  apply: ->
    super()
    @context.worker.add('strength', effect())


Place.Research::jobs.sexyGym = RoomJob.SexyGym = class SexyGym extends RoomJob
  label: "Nude Gym"
  progress: 500
  text: ->"""<span class="strength">+1 Strength</span> when training in the gym.
  <br>Really, clothes just get in the way when you're exercising."""

RoomJob.SexyGym::next = Page.SexyGym = class SexyGym extends Page
  text: ->"""|| bg="Gym/Nude1.jpg"
    -- I've added all sorts of fun games to the gym. Catch her you get to fuck her. He catches you he fucks you. Lift ten more pounds than last week and get a blowjob.
   ||
     --> Ok, not really "all sorts."
   ||
     --> Look, I'm the Dark Lady. I like to stick with what I know.
  """
