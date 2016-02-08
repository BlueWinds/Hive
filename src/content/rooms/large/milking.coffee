add class Milking extends RoomJob
  label: "Milking Barn"
  size: 'large'
  conditions:
    '|events|MoreResources': {}
  effects:
    depravity: -100
    men: -4
    women: -2
    virgins: -2
  text: ->"""While human women don't produce that much milk, I find the humiliation delightful, and the rows of distended breasts and chained cunts ready for use is its own reward. Oh, and they do produce <em>some</em> milk, which is quite useful magically."""

add class Milking extends Page
  text: -> """|| bg="Milking/5"
    -- Cowgirls. Milking machines. Sweet. Slutrooms are great for sex magic, but they don't produce much milk. A room stuffed to the brim with constantly stimulated and milked women is just the ticket.
  """

milkingMax = ->
  max = 6
  if g.events.ExtraPens then max += 6
  return max

effect = (workers)->
  fraction = if g.events.MilkingPregnancy then 2 else 3
  return Math.round(workers / fraction)

add class Milking extends Job
  label: "Milking Barn"
  text: -> """A whole bunch of mooing slaves, all getting milked and occasionally fucked. I love this place.

  #{@workers} out of #{milkingMax()} stalls are filled.

  <em><span class="depravity">+#{effect @workers}</span>, <span class="milk">+#{effect @workers}</span> daily.</em>"""
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
    || bg="Milking/Add"
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
    job: '|last'
    depravity: fill: -> effect @job.workers
    milk: fill: -> effect @job.workers
  text: ->
    if $('page').length and (Math.random() < 0.75 or g.events.MilkingDaily?[1] is g.day) then return false

    c = [
      """|| bg="Milking/1"
        -- The cows need to be stimulated at least once an hour for optimum production. It's a demanding job, but a combination of male and female staff keep them working at their full potential 12 hours a day."""
      """|| bg="Milking/2"
        -- Happy cows are productive cows! After their mandatory two hour exercise break, look at how excited they are to be strapped back in!"""
      """|| bg="Milking/3"
        -- It's visitors' day! The milk store has a <em>very</em> popular customer loyalty program."""
      """|| bg="Milking/4"
        -- Aww, looks like she hasn't accepted her now place yet. Don't worry, honey, you may have been kidnapped, brutallized and turned into human livestock, but you'll forget all about your old life in a month or two."""
    ]
    if g.events.MilkingPregnancy
      c.push """|| bg="Milking/Preg1"
        -- Pregnant cows are put in different positions throughout the work day to help ensure their health and the health of their children."""
      c.push """|| bg="Milking/Preg2"
        -- Some cows volunteer for permanent installation, and are rewarded with 24-hour clitoral attachments. Stimulated constantly, milked twice and day, and pregnant for the rest of their lives - they'll never use their arms and legs again."""
      c.push """|| bg="Milking/Preg3"
        -- Taking some of the cows out for a walk. They're blindfolded so all the overstimulation of the outside world doesn't distract too much."""
      c.push """|| bg="Milking/Preg4"
        -- Budget cuts and labor shortages can hit even magical sex-economies. Automation is the answer."""

    return """|| class="jobStart" auto="1800"
        <h4>Milking Barn</h4>

    """ +  Math.choice c
  effects:
    depravity: 'depravity'
    milk: 'milk'

add class ExtraPens extends ResearchJob
  conditions:
    '|events|Milking': {}
  label: "Additional Pens"
  progress: 500
  text: ->"""+6 space in each Milking Barn
  <br>The architect was an idiot. Of course we want the cows crammed in tightly. These are sexy cows, and if they want to caress each other, we should let them!"""

add class ExtraPens extends Page
  text: ->"""|| bg="Milking/2"
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
  progress: 600
  text: ->"""+50% Milk and D production in each Milking Barn
  <br>Who in the world thought that giving the milk cows contraceptives was a good idea? I mean, sure we have to redesign a bit to accommodate the different body shape, but..."""

add class MilkingPregnancy extends Page
  text: ->"""|| bg="Milking/Preg1"
    -- Q. Should I have a baby after 35?
       A. No, 35 children is enough.

       Q. What is the most reliable method to determine a baby’s sex?
       A. Childbirth.

    -- Q. How does one sanitize nipples?
       A. Bathe daily and wear a clean bra. It beats boiling them in a saucepan.

       Q. Our baby was born last week. When will my wife act normal again?
       A. When your child is in college.
  """
