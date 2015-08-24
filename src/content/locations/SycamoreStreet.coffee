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
    -- #{@worker} is bored. #{He} wandered the streets looking for someone to catch, but found nothing. Perhaps rumors of how dangerous the area has become have spread, or perhaps there was a college football game drawing everyone away.
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
    <em><span class="lust">-1 Lust</span>, <span class="intelligence">-1 Intelligence</span></em>
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


Job.Catch.next['veryGood'] = Page.CatchVeryGood = class CatchVeryGood extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.CatchMan,
    Page.CatchWoman,
    Page.CatchWoman,
    Page.CatchWoman,
    Page.CatchVirgin,
    Page.CatchVirgin
  ]

Job.Catch.next['good'] = Page.CatchGood = class CatchGood extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.CatchNothing,
    Page.CatchNothing,
    Page.CatchMan,
    Page.CatchWoman
  ]

Job.Catch.next['bad'] = Page.CatchBad = class CatchBad extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.CatchPolice,
    Page.CatchNothing,
    Page.CatchMiss,
    Page.CatchMiss,
    Page.CatchMiss
  ]

Job.Catch.next['veryBad'] = Page.CatchVeryBad = class CatchVeryBad extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.CatchPolice,
    Page.CatchPoliceCapture
  ]

Place.Sycamore::jobs.rentWarehouse = Job.RentWarehouse = class RentWarehouse extends Job
  officers:
    Liana: '|officers|Liana'
  label: 'Rent Warehouse Space'
  text: ->"""Liana says she can acquire more room for exansion. She's a good girl, really, and extra space to build in is worth letting her put on clothes for (only temporarily, of course).

  <span class="depravity">-150</span>"""
  next: Page.firstNew
  @next: []

Job.RentWarehouse.next.push Page.RentWarehouse1 = class RentWarehouse1 extends Page
  text: """|| bg="Sycamore/Street.jpg"
    -- After a bit of negotiating with one of the property owners on Sycamore Street, Liana has acquired a new location for me to exand into.
  || bg="Liana/Gangbang.jpg"
    --> As a reward for all her hard work, I let a bunch of slaves gangbang her.
    <em>+1 Medium room, <span class="depravity">-150</span></em>"""
  effects:
    depravity: -150
    add:
      '|map|Sycamore|jobs|1': Job.MediumRoom

Job.RentWarehouse.next.push Page.RentWarehouse1 = class RentWarehouse1 extends Page
  text: """|| bg="Sycamore/Street.jpg"
    -- After a bit of negotiating with one of the property owners on Sycamore Street, Liana has acquired a new location for me to exand into. It was a bit more expensive than she anticipatied, but she managed in the end.
  || bg="Liana/Gangbang.jpg"
    --> As a punishment for wasting my money, I let a bunch of slaves gangbang her.
    <em>+1 Medium room, <span class="depravity">-175</span></em>"""
  effects:
    depravity: -175
    add:
      '|map|Sycamore|jobs|1': Job.MediumRoom
      
