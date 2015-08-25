Place.Sycamore = Game::map.Sycamore = class Sycamore extends Place
  name: 'Sycamore Street'
  description: "Empty businesses, boarded up windows, hookers, broken bottles... it's not much, it's a place to start."
  image: 'Sycamore/Street.jpg'
  jobs: new Collection
  location: [633, 354]
  destinations: new Collection
    HolidayInn: -1

Place.Sycamore::jobs.Catch = Job.Catch = class Catch extends Job
  conditions:
    '|freeSpace': gte: 1
  officers:
    worker: {}
  label: 'Catch Slaves'
  text: ->"""Snatching people off the street is the simplest - but also most dangerous - way to get new slaves.

  #{Page.statCheckDescription('strength', 30, Job.Catch.next, @context)}"""
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
    Page.CatchPoliceCapture,
    Page.CatchPoliceCapture
  ]

Place.Sycamore::jobs.rentWarehouse = Job.RentWarehouse = class RentWarehouse extends Job
  officers:
    Liana: '|officers|Liana'
  conditions:
    '|depravity': gte: 150
    '|events|RentWarehouse|length':
      lt: 4
      optional: true
  label: 'Rent Warehouse'
  text: ->"""Liana says she can acquire more room for expansion. She's a good girl, really, and extra space to build in is worth letting her put on clothes for (only temporarily, of course).

  <span class="depravity">-150</span>"""
  next: Page.firstNew
  @next: []

Job.Tunnel = class Tunnel extends Job
  progress: 0
  needed: 100
  officers:
    worker:
      matches: -> if g.depravity < 5 then false else true
      label: -> if g.depravity < 5 then 'Need depravity' else ''
    worker2:
      matches: -> if g.depravity < 5 then false else true
      label: -> if g.depravity < 5 then 'Need depravity' else ''
      optional: true
  label: 'Dig Tunnel'
  text: ->"""While the Holiday Inn is a single building, I can't move naked - or unwilling and chained up - slaves freely along city streets. I need a tunnel. <em class="depravity">-5</em>

    <strong>#{@progress} / #{@needed}</strong>
    Daily progress: <span class="strength">Strength</span>"""
  effects:
    depravity: -5
  apply: ->
    super()
    @progress += @context.worker.strength
    @progress += @context.worker2?.strength or 0

Job.RentWarehouse.next.push Page.RentWarehouse1 = class RentWarehouse1 extends Page
  text: ->"""|| bg="Sycamore/Street.jpg"
    -- After a bit of negotiating with one of the property owners on Sycamore Street, Liana has acquired a new location for me to expand into.
  || bg="Liana/Gangbang.jpg"
    --> As a reward for all her hard work, I let a bunch of slaves gangbang her.
    <em>+1 Medium room, <span class="depravity">-150</span></em>"""
  effects:
    depravity: -150
    add:
      '|map|Sycamore|jobs|1': Job.Tunnel

Job.Tunnel::next = Page.Tunnel = class Tunnel extends Page
  jobKey: 1
  conditions:
    progress: '|last|progress'
    needed: '|last|needed'
  text: ->"""|| bg="Sycamore/Tunnel1.jpg"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""
  apply: ->
    super()
    if @context.progress >= @context.needed
      g.map.Sycamore.jobs[@jobKey] = new Job.MediumRoom

Job.Tunnel2 = class Tunnel2 extends Job.Tunnel
  needed: 200

Job.RentWarehouse.next.push Page.RentWarehouse2 = class RentWarehouse2 extends Page
  text: ->"""|| bg="Sycamore/Street.jpg"
    -- After a bit of negotiating with one of the property owners on Sycamore Street, Liana has acquired a new location for me to expand into. It was a bit more expensive than anticipated, but she managed in the end.
  || bg="Liana/Gangbang.jpg"
    --> As a punishment for wasting my money, I let a bunch of slaves gangbang her.
    <em>+1 Medium room, <span class="depravity">-175</span></em>"""
  effects:
    depravity: -175
    add:
      '|map|Sycamore|jobs|2': Job.Tunnel2

Job.Tunnel2::next = Page.Tunnel2 = class Tunnel2 extends Page.Tunnel
  jobKey: 2
  text: ->"""|| bg="Sycamore/Tunnel2.jpg"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""

Job.Tunnel3 = class Tunnel3 extends Job.Tunnel
  needed: 400

Job.RentWarehouse.next.push Page.RentWarehouse3 = class RentWarehouse3 extends Page
  text: ->"""|| bg="Sycamore/Street.jpg
    -- Liana did good. I have a new building all my own, with a couple of smaller rooms I can fill up with fun toys for my slaves.
  || bg="Liana/Gangbang.jpg"
    --> I gave her a break from all the hard work she does on my behalf with a nice relaxing gangbang."""
  effects:
    depravity: -150
    add:
      '|map|Sycamore|jobs|3': Job.Tunnel3

Job.Tunnel3::next = Page.Tunnel3 = class Tunnel3 extends Page.Tunnel
  text: ->"""|| bg="Sycamore/Tunnel3.jpg"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""
  apply: ->
    super()
    if @context.progress >= @context.needed
      g.map.Sycamore.jobs[3] = new Job.SmallRoom
      g.map.Sycamore.jobs[3.5] = new Job.SmallRoom

Job.Tunnel4 = class Tunnel4 extends Job.Tunnel
  needed: 800

Job.RentWarehouse.next.push Page.RentWarehouse4 = class RentWarehouse4 extends Page
  text: ->"""|| bg="Sycamore/Street.jpg
    -- Empty warehouse space? Sure, I love empty warehouse space!
  || bg="Liana/Gangbang.jpg"
    --> Shame it took so long. Maybe a nice brutal gangbang will convince Liana to work faster next time."""
  effects:
    depravity: -175
    add:
      '|map|Sycamore|jobs|4': Job.Tunnel4

Job.Tunnel4::next = Page.Tunnel4 = class Tunnel4 extends Page.Tunnel
  jobKey: 4
  text: ->"""|| bg="Sycamore/Tunnel4.jpg"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""
