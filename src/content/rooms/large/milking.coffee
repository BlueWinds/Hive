add class Milking extends RoomJob
  label: "Milking Barn"
  size: 'large'
  effects:
    depravity: -100
    men: -4
    women: -2
    virgins: -2
  text: ->"""While human women don't usually produce that much milk, I find the humiliation delightful, and the rows of distended breasts and chained cunts ready for use is its own reward."""

add class Milking extends Page
  text: -> """|| bg="Milking/5.jpg"
    -- Cowgirls. Milking machines. Sweet. Slutrooms are great, but I can pull a whole lot more sex magic out of a room stuffed to the brim with constantly stimulated and milked women than I can from just two slaves.
  """

milkingMax = ->
  max = 9
  if g.events.ExtraPens then max += 3
  if g.events.MilkingPregnancy then max += 3
  return max

add class Milking extends Job
  label: "Milking Barn"
  text: -> """A whole bunch of mooing slaves, all getting milked and occasionally fucked. I love this place.

  #{@workers} out of #{milkingMax()} stalls are filled.

  <em><span class="depravity">+#{@workers}</span> daily.</em>"""
  people:
    worker:
      optional: true
      matches: (worker, job)-> g.women and job.workers < milkingMax()
      label: ->
        if g.women and @workers < milkingMax() then 'Add <span class="women"></span>'
        else if g.women then 'Already full'
        else 'Need <span class="women"></span>'
  next: Page.firstMatch
  @next: []
  type: 'boring'
  workers: 2

Job.Milking.next.push add class MilkingAdd extends Page
  conditions:
    worker: {}
    job: '|last'
  text: ->
    """|| class="jobStart" auto="1800"
      <h4>Milking Barn</h4>
    || bg="Milking/Add.jpg"
      -- Fresh meat for a new milking stall. Don't worry, her breasts will fill out soon enough.
      <em><span class="women">-1</span>, <span class="depravity">+1</span> daily</em>
    """
  apply: ->
    super()
    @context.job.workers += 1
  effects:
    women: -1

Job.Milking.next.push add class MilkingDaily extends Page
  conditions:
    depravity: '|last|workers'
  text: ->
    if g.events.MilkingDaily?[1] is g.day or Math.random() > 0.25 then return false
    """|| class="jobStart" auto="1800"
        <h4>Milking Barn</h4>

    """ +  Math.choice [
      """|| bg="Milking/1.jpg"
        -- The cows need to be stimulated at least once an hour for optimum production. It's a demanding job, but a combination of male and female staff keep them working at their full potential 12 hours a day.""",
      """|| bg="Milking/2.jpg"
        -- Pregnant cows are put in different positions throughout the work day to help ensure their health and the health of their children.""",
      """|| bg="Milking/3.jpg"
        -- It's visitors' day! The milk store has a <em>very</em> popular customer loyalty program.""",
      """|| bg="Milking/4.jpg"
        -- Aww, looks like she hasn't accepted her now place yet. Don't worry, honey, you may have been kidnapped and brutally turned into human livestock, but you'll forget all about your old life in a month or two.""",
      """|| bg="Milking/5.jpg"
        -- Happy cows are productive cows! After their mandatory two hour exercise break, look at how excited they are to be strapped back in!""",
    ]
  effects:
    depravity: 'depravity'

add class ExtraPens extends RoomJob
  conditions:
    '|events|Milking': {}
  label: "Additional Pens"
  progress: 500
  text: ->"""+3 space in each Milking Barn
  <br>The architect was an idiot. Of course we want the cows crammed in tightly. These are sexy cows, and if they want to caress each other, we should let them!"""

add class ExtraPens extends Page
  text: ->"""|| bg="Milking/5.jpg"
    -- There once was a farmer named Jill,
      Who used a milking machine for a thrill.
      She let out a great shout
      When she couldn't pull them out
      For it was set for a 16 quart fill.
  """

add class MilkingPregnancy extends ResearchJob
  conditions:
    '|events|Milking': {}
  label: "Pregnant Cows"
  progress: 1000
  text: ->"""+3 space in each Milking Barn
  <br>Who in the world thought that giving the milk cows contraceptives was a good idea? I mean, sure we have to redesign a bit to accommodate the different body shape, but..."""

add class MilkingPregnancy extends Page
  text: ->"""|| bg="Milking/2.jpg"
    -- Q. Should I have a baby after 35?
       A. No, 35 children is enough.

       Q. What is the most reliable method to determine a baby’s sex?
       A. Childbirth.

    -- Q. How does one sanitize nipples?
       A. Bathe daily and wear a clean bra. It beats boiling them in a saucepan.

       Q. Our baby was born last week. When will my wife act normal again?
       A. When your child is in college.
  """
