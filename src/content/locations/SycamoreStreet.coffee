Place.Sycamore = Game::map.Sycamore = class Sycamore extends Place
  name: 'Sycamore Street'
  description: "Empty businesses, boarded up windows, hookers, broken bottles... it's not much, it's a place to start."
  image: 'Sycamore/Street.jpg'
  jobs: new Collection
  location: [633, 354]
  destinations: new Collection
    HolidayInn: -1

Place.Sycamore::jobs.Catch = Job.Catch = class Catch extends Job
  officers:
    worker: {}
  label: 'Catch Slaves'
  text: ->"""Snatching people off the street is the simplest - but also most dangerous - way to get new slaves.

  #{Page.statCheckDescription('strength', 30, Page.Catch.next, @context)}"""

Job.Catch::next = Page.Catch = class Catch extends Page
  conditions:
    worker: {}
  text: ->false
  stat: 'strength'
  difficulty: 30
  next: Page.statCheck
  @next: {}

Page.CatchPolice = class CatchPolice extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Police.jpg"
    -- It went poorly. #{if @worker is g.officers.DarkLady then 'I' else ('My ' + @worker)} was shot by the police, though #{if @worker is g.officers.DarkLady then 'I' else he()} did manage to escape. At least the officer was hot.
    <em><span class="strength">-6 strength</span></em>
  """
  apply: ->
    super()
    @context.worker.add 'strength', -6

Page.CatchPoliceCapture = class CatchPoliceCapture extends Page
  conditions:
    worker:
      isnt: [Officer.DarkLady, Officer.Liana]
  text: ->"""|| bg="Sycamore/Police.jpg"
    -- My #{@worker} has been captured by the police! Damn it. I'll have to trigger the remote memory erasure spell I implanted - #{he} won't be of any more use to me, but at least they won't be able to get any information out of #{him}.
    <em>#{@worker} is captured.</em>
  """
  apply: ->
    super()
    g.officers.remove @context.worker

Page.CatchNothing = class CatchNothing extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street.jpg"
    -- #{@worker} is bored. #{She} wandered the streets looking for someone to catch, but found nothing. Perhaps rumors of how dangerous the area has become have spread, or perhaps there was a college football game drawing everyone away.
    <em><span class="lust">-1 Lust</span></em>
  """
  apply: ->
    super()
    @context.worker.add 'lust', -1

Page.CatchMiss = class CatchMiss extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street.jpg"
    -- #{@worker} cornered a young #{Math.choice ['man', 'woman']}, but they kicked #{his} shins and knocked him into a wall escaped. It hurt not only #{his} pride, but also #{his} head.
    <em><span class="lust">-1 Lust</span>, <span class="intelligence">-1 Lust</span></em>
  """
  apply: ->
    super()
    @context.worker.add 'lust', -1
    @context.worker.add 'intelligence', -1

Page.CatchMan = class CatchMan extends Page
  text: ->"""|| bg="Sycamore/#{Math.choice ['CaptureM1', 'CaptureM2']}.jpg"
    -- <em><span class="men">+1</span></em>
  """
  effects:
    men: 1

Page.CatchWoman = class CatchWoman extends Page
  text: ->"""|| bg="Sycamore/#{Math.choice ['CaptureF1', 'CaptureF2']}.jpg"
    -- <em><span class="women">+1</span></em>
  """
  effects:
    women: 1

Page.CatchVirgin = class CatchVirgin extends Page
  text: ->"""|| bg="Sycamore/CaptureF3.jpg"
    -- <em><span class="virgins">+1</span></em>
  """
  effects:
    virgins: 1


Page.Catch.next['veryGood'] = Page.CatchVeryGood = class CatchVeryGood extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.randomMatch
  @next: [
    Page.CatchMan,
    Page.CatchWoman,
    Page.CatchWoman,
    Page.CatchWoman,
    Page.CatchVirgin,
    Page.CatchVirgin
  ]

Page.Catch.next['good'] = Page.CatchGood = class CatchGood extends Page.CatchVeryGood
  @next: [
    Page.CatchMiss,
    Page.CatchMiss,
    Page.CatchMan,
    Page.CatchWoman
  ]

Page.Catch.next['bad'] = Page.CatchBad = class CatchBad extends Page.CatchVeryGood
  @next: [
    Page.CatchPolice,
    Page.CatchNothing,
    Page.CatchMiss,
    Page.CatchMiss,
    Page.CatchMiss
  ]

Page.Catch.next['veryBad'] = Page.CatchVeryBad = class CatchVeryBad extends Page.CatchVeryGood
  @next: [
    Page.CatchPolice,
    Page.CatchPoliceCapture
  ]
