add class Sycamore extends Place
  name: 'Sycamore Street'
  description: "Empty businesses, boarded up windows, hookers, broken bottles... it's not much, but it's a place to start."
  image: 'Sycamore/Street'
  jobs: new Collection
    Fire: Job.Fire
  location: [633, 354]
  destinations: new Collection

add class Resistance extends Job
  place: 'Sycamore'
  type: 'plot'
  people:
    'Dark Lady': '|people|DarkLady'
    Liana: '|people|Liana'
  label: 'Walk with Liana'
  text: ->"""Liana has something she wants to talk to me about, something-something police we're doomed. Perhaps I'd better listen."""

Job.Resistance::next = add class Resistance extends Page
  text: ->"""|| bg="Sycamore/Street"
    -- Liana leads me out into the daylight. It's not my favorite place to be - rather exposed to the accursed daystar, nothing fun happening near... wait, nope, I hear people fucking in one of the buildings nearby. Nothing fun happening nearby <i>that I get to watch.</i> My lieutenant seems rather happy, which I suppose is a good thing.
  || bg="Liana/Coat"
    -- `L You know, when I summoned you I just wanted to abduct my professors, torture them a bit, maybe make them run around naked. I wasn't expecting you to be quite so... vigerous. Taking over everything's fun, mind you, just not what I was expecting to do.`
    --> I smirk, wait for her to go on.
    --> `L Anyway, I wanted to warn you about how things work here in the modern world. You can maybe get away with a couple of disappearances here or there, but too much more of what we did back at the motel and you'll start attracting attention. I'm amazed no one's reported your slaves missing yet.`

    -- `D Of course not. I've woven a Forgetting over our activities. People forget their suspicions unusually quickly in its presence.`
    --> `L Really? That's useful. I haven't felt anything.`
    --> `D Of course not. It would be a poor spell if it could be noticed casually. You're immune, of course, being a mage. Search for it sometime, you'll feel it blanketing the town.`
    --> Liana blinks a few times, looking puzzled. Right. She's not a mage yet, just a dabbling ameture. I explain how she can see magical energy. An amature, but a gifted one - she picks up the principle instantly.

    -- `L Anyway, that's what I wanted to tell you, but it sounds like you already know.` She smiles and twirls, long hair flowing in the wind.
    --> `D Your skirt.`
    --> `L What?`
    --> `D If we're done talking, give me your skirt.`

  || bg="Liana/noPants"
    -- <em>Resistance (R) is a number ranging from 0-100, representing how suspicious and alert the town is. It adds to the difficulty of all stat checks, making you less likely to succeed. It decays slowly on its own (due to the Dark Lady's spell), though eventually you'll find other ways to decrease it later.</em>

    <em><span class="resistance">+5</span></em>
  """
  apply: ->
    super()
    g.resistance = 5
  effects:
    remove:
      '|map|Sycamore|jobs|Resistance': Job.Resistance

add class Catch extends Job
  place: 'Sycamore'
  conditions:
    '|freeSpace': gte: 1
    '|events|Resistance': {}
  people:
    worker: {}
  label: 'Catch Slaves'
  text: ->"""Snatching people off the street is the simplest - but also most dangerous - way to get new slaves.

  <span class="resistance">+1 to +5</span>
  #{Page.statCheckDescription('strength', 30, Job.Catch.next, @context)}"""
  stat: 'strength'
  difficulty: 20
  next: Page.statCheck
  @next: {}

add class CatchPolice extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Police"
    -- It went poorly. #{if @worker is g.people.DarkLady then 'I' else ('My ' + @worker)} was shot by the police, though #{if @worker is g.people.DarkLady then 'I' else he()} did manage to escape. At least the officer was hot.
    <em><span class="strength">-6 strength</span>, <span class="resistance">+5</span></em>
  """
  apply: ->
    super()
    @context.worker.add 'strength', -6
    g.resistance += 5

add class CatchPoliceCapture extends Page
  conditions:
    worker:
      isnt: [Person.DarkLady, Person.Liana]
  text: ->"""|| bg="Sycamore/Police"
    -- My #{@worker} has been captured by the police! Damn it. I'll have to trigger the remote memory erasure spell I implanted - #{he} won't be of any more use to me, but at least they won't be able to get any information out of #{him}.
    <em>#{@worker} is captured. <span class="resistance">+5</span></em>
  """
  apply: ->
    super()
    g.people.remove @context.worker
    g.resistance += 5

add class CatchNothing extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street"
    -- #{@worker} is bored. #{He} wandered the streets looking for someone to catch, but found nothing. Perhaps rumors of how dangerous the area has become have spread, or perhaps there was a college football game drawing everyone away.
    <em><span class="lust">-1 Lust</span>, <span class="resistance">+1</span></em>
  """
  apply: ->
    super()
    @context.worker.add 'lust', -1
    g.resistance += 1

add class CatchMiss extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street"
    -- #{@worker} cornered a young #{Math.choice ['man', 'woman']}, but they kicked #{his} shins and knocked him into a wall escaped. It hurt not only #{his} pride, but also #{his} head.
    <em><span class="lust">-1 Lust</span>, <span class="intelligence">-1 Intelligence</span>, <span class="resistance">+3</span></em>
  """
  apply: ->
    super()
    @context.worker.add 'lust', -1
    @context.worker.add 'intelligence', -1
    g.resistance += 2

add class CatchMan extends Page
  text: ->"""|| bg="Sycamore/#{Math.choice ['CaptureM1', 'CaptureM2']}"
    -- <em><span class="men">+1</span>, <span class="resistance">+3</span></em>
  """
  effects:
    men: 1
    resistance: 3

add class CatchWoman extends Page
  text: ->"""|| bg="Sycamore/#{Math.choice ['CaptureF1', 'CaptureF2']}"
    -- <em><span class="women">+1</span>, <span class="resistance">+4</span></em>
  """
  effects:
    women: 1
    resistance: 4

add class CatchVirgin extends Page
  text: ->"""|| bg="Sycamore/CaptureF3"
    -- <em><span class="virgins">+1</span>, <span class="resistance">+5</span></em>
  """
  effects:
    virgins: 1
    resistance: 5


Job.Catch.next['veryGood'] = add class CatchVeryGood extends Page
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

Job.Catch.next['good'] = add class CatchGood extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.CatchMan,
    Page.CatchWoman
  ]

Job.Catch.next['bad'] = add class CatchBad extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.CatchPolice,
    Page.CatchNothing,
    Page.CatchMiss
  ]

Job.Catch.next['veryBad'] = add class CatchVeryBad extends Page
  conditions:
    worker: {}
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.CatchPolice,
    Page.CatchPoliceCapture,
    Page.CatchPoliceCapture
  ]

choices = ->
  c = {}
  if g.men then c.men = 'men'
  if g.women then c.women = 'women'
  if g.virgins then c.virgins = 'virgins'
  if Object.keys(c).length is 0 then c[''] = ''
  return c

releaseValue =
  men: 5
  women: 10
  virgins: 25

add class Release extends Job
  place: 'Sycamore'
  choice: 'men'
  label: 'Release Slave'
  type: 'boring'
  conditions:
    '|events|Laboratory': {}
  text: ->"""I've got a lot of #{dropdown choices(), @choice} in my dungeons. I can have some fun and clean up space at the same time!

    <span class="#{@choice}">-1</span>, <span class="depravity">+#{releaseValue[@choice] or 0}</span>, <span class="resistance">-1</span>
  """
  renderBlock: (mainKey, location)->
    unless choices()[@choice]? then @choice = Object.keys(choices())[0]
    element = $ super(mainKey, location)
    element.on 'change', 'input', =>
      @choice = $('input:checked', element).val()
    return element
  people:
    worker:
      matches: (person, job)->
        if not job.choice then false
        else true
      label: ->
        if @choice then '' else 'Need slave'

add class Release extends Page
  conditions:
    choice: '|last|choice'
  text: ->
    if Math.random() < 0.75 then return false
    c = if @choice is 'men' then [
      """|| bg="Sycamore/Street"
        -- My trusted servant released one of the men at the end of Sycamore Street. He won't remember a thing."""
    ] else [
      """|| bg="Sycamore/Release1"
        -- Some markers, some rope, a public restroom... I wiped her memory of her time with me and left her there. I'm sure someone will let her out eventually, but for now... public use. Just giving back to the community which has given me so much.""",
      """|| bg="Sycamore/Release2"
        -- A bit of magical soundproofing on the box so no one gets suspicious, a letter detailing her circumstances (half-trained slave needs new home), and a random address halfway across the country. Someone's day just got brighter.""",
      """|| bg="Sycamore/Release3"
        -- Special delivery for the college football team's locker room.""",
      """|| bg="Sycamore/Release4"
        -- I made a Liana take her to the tallest building in town and leave her locked in a closet overnight. I wonder if the janitor will have some fun before he lets her go?""",
      """|| bg="Sycamore/Release5"
        -- The wonderful thing about magic is that no one else in this age seems to have it. That thing will vibrate randomly throughout the day, and it will *not* come out for at least a month.""",
      """|| bg="Sycamore/Release6"
        -- One of my servants left her in the kitchen of a random house, one leg chained in place. She'll have to wait for them to get home from work."""
    ]

    """|| class="jobStart" auto="1800"
      <h4>Release Slave</h4>

    #{Math.choice c}
      <span class='#{@choice}'>-1</span>, <span class='depravity'>+#{releaseValue[@choice]}</span>, <span class="resistance">-1</span>"""
  apply: ->
    super()
    effects =
      depravity: releaseValue[@context.choice]
      resistance: -1
    effects[@context.choice] = -1
    g.applyEffects(effects)

add class RentWarehouse extends Job
  place: 'Sycamore'
  people:
    Liana: '|people|Liana'
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

add class Tunnel extends Job
  progress: 0
  needed: 100
  people:
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

Job.RentWarehouse.next.push add class RentWarehouse1 extends Page
  text: ->"""|| bg="Sycamore/Street"
    -- After a bit of negotiating with one of the property owners on Sycamore Street, Liana has acquired a new location for me to expand into.
  || bg="Liana/Gangbang"
    --> As a reward for all her hard work, I let a bunch of slaves gangbang her.
    <em>+1 Medium room, <span class="depravity">-150</span></em>"""
  effects:
    depravity: -150
    add:
      '|map|Sycamore|jobs|1': Job.Tunnel

add class Tunnel extends Page
  jobKey: 1
  conditions:
    progress: '|last|progress'
    needed: '|last|needed'
  text: ->"""|| bg="Sycamore/Tunnel1"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""
  apply: ->
    super()
    if @context.progress >= @context.needed
      g.map.Sycamore.jobs[@jobKey] = new Job.MediumRoom

add class Tunnel2 extends Job.Tunnel
  needed: 200

Job.RentWarehouse.next.push add class RentWarehouse2 extends Page
  text: ->"""|| bg="Sycamore/Street"
    -- After a bit of negotiating with one of the property owners on Sycamore Street, Liana has acquired a new location for me to expand into. It was a bit more expensive than anticipated, but she managed in the end.
  || bg="Liana/Gangbang"
    --> As a punishment for wasting my money, I let a bunch of slaves gangbang her.
    <em>+1 Medium room, <span class="depravity">-175</span></em>"""
  effects:
    depravity: -175
    add:
      '|map|Sycamore|jobs|2': Job.Tunnel2

add class Tunnel2 extends Page.Tunnel
  jobKey: 2
  text: ->"""|| bg="Sycamore/Tunnel2"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""

add class Tunnel3 extends Job.Tunnel
  needed: 400

Job.RentWarehouse.next.push add class RentWarehouse3 extends Page
  text: ->"""|| bg="Sycamore/Street"
    -- Liana did good. I have a new building all my own, with a couple of smaller rooms I can fill up with fun toys for my slaves.
  || bg="Liana/Gangbang"
    --> I gave her a break from all the hard work she does on my behalf with a nice relaxing gangbang."""
  effects:
    depravity: -150
    add:
      '|map|Sycamore|jobs|3': Job.Tunnel3

add class Tunnel3 extends Page
  conditions:
    progress: '|last|progress'
    needed: '|last|needed'
  text: ->"""|| bg="Sycamore/Tunnel3"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""
  apply: ->
    super()
    if @context.progress >= @context.needed
      g.map.Sycamore.jobs[3] = new Job.SmallRoom
      g.map.Sycamore.jobs[4] = new Job.SmallRoom

add class Tunnel4 extends Job.Tunnel
  needed: 800

Job.RentWarehouse.next.push add class RentWarehouse4 extends Page
  text: ->"""|| bg="Sycamore/Street"
    -- Empty warehouse space? Sure, I love empty warehouse space!
  || bg="Liana/Gangbang"
    --> Shame it took so long. Maybe a nice brutal gangbang will convince Liana to work faster next time."""
  effects:
    depravity: -175
    add:
      '|map|Sycamore|jobs|5': Job.Tunnel4

add class Tunnel4 extends Page.Tunnel
  jobKey: 5
  text: ->"""|| bg="Sycamore/Tunnel4"
    -- <strong>#{@progress} / #{@needed}</strong>
    <em class="depravity">-5</em>"""

whoreDepravity = (context)->
  lust = (context.w1?.lust or 0) + (context.w2?.lust or 0) + (context.w3?.lust or 0)
  return Math.floor(lust / 6)

add class Whore extends Job
  place: 'Sycamore'
  conditions:
    '|events|SexSlave': {}
  type: 'boring'
  label: 'Prostitution'
  text: ->"""Sycamore Street isn't the nicest part of town, so one of my sluts selling her body won't be that unusual of a sight.

  <em><span class="depravity">+#{whoreDepravity(@context)}</span>, <span class="resistance">+1</span></em>"""
  people:
    pimp:
      label: ->'Domme or Sadist'
      is: [Person.Domme, Person.Sadist]
    w1:
      label: ->'Slut'
      is: [Person.SexSlave, Person.Liana, Person.ManWhore, Person.Catgirl, Person.Catboy]
    w2:
      label: ->'Slut'
      is: [Person.SexSlave, Person.Liana, Person.ManWhore, Person.Catgirl, Person.Catboy]
      optional: true
    w3:
      label: ->'Slut'
      is: [Person.SexSlave, Person.Liana, Person.ManWhore, Person.Catgirl, Person.Catboy]
      optional: true

add class Whore extends Page
  conditions:
    depravity: fill: -> whoreDepravity(g.last.context)
    w1: {}
    pimp: {}
  text: ->
    if $('page').length and Math.random() < 0.75 then return false

    c = []
    inof = (cl)=> return @w1 instanceof cl or @w2 instanceof cl or @w3 instanceof cl

    if inof Person.SexSlave then c.push.apply c, [
      """|| bg="Sycamore/Whore1"
        -- Condoms are sexy! He lasts longer, she doesn't waste my magic needing to be cured of diseases."""
      """|| bg="Sycamore/Whore2"
        -- He was a little rough, but she took her pounding like a champ. As high earner for the month, she deserves a reward - if I remember tomorrow, I'll make Liana serve her for a few hours."""
      """|| bg="Sycamore/Whore3"
        -- "That's a good little slut. You like it and you hate the way it lets me see what you really want. Go on, tell me to stop if that's what you're actually thinking..."
        --> He's a bit corny, but, well, as long as he's paying she's hardly in a position to complain."""
      """|| bg="Sycamore/Whore4"
        -- Some girls go in for a more cute and innocent look. Works pretty well, especially when their clients learn they're not wearing underwear."""
      """|| bg="Sycamore/Whore5"
        -- Whore. She won't even open her mouth until he's ready to shove a cock in it."""
      """|| bg="Sycamore/Whore6"
        -- #{@pimp} gets a call from a guy we've seen before. He wants our girl to 'bring extra condoms this time.' Looks like she's in for a long night."""
    ]

    if inof Person.Liana then c.push.apply c, [
      """|| bg="Liana/Whore1"
        -- While it's true that I've corrupted Liana to some extent, she somehow retains a core of purity and joy that perhaps I <em>could</em> touch, but really have no desire to. She's a powerful mage, a feisty temptress, smart and loyal and... I must be coming down with something.
      ||
        --> Snapping the scrying window closed, I order someone to bring me a cup of pineapple juice, a butt plug and a hole to put it in. I'm supposed to be taking over the world, not feeling jealous of some mere human about to fuck her senseless.
        -->"""
      """|| bg="Liana/Whore21"
      || bg="Liana/Whore22"
      || bg="Liana/Whore23"
      || bg="Liana/Whore23"
        -- "Wow that went in easy. You have lots of experience?"
        `L That's a myth. It went in easy because I'm turned on.`
        "Oh. Well, you're a slut either way."
        -->
      """
    ]

    if inof Person.ManWhore then c.push.apply c, [
      """|| bg="Sycamore/WhoreMale1"
        -- Tempting as it is to grab her for my own collection, any woman who's going to pay a man off the street for sex is a woman too valuable to just throw in a cell and brainwash."""
      """|| bg="Sycamore/WhoreMale2"
        -- """
      """|| bg="Sycamore/WhoreMale3"
        -- Seriously, what sort of guy just carries a leash and collar in his pocket, in case he happens to stumble across some casual sex?
        --> The awesome kind, clearly."""
      """|| bg="Sycamore/WhoreMale4"
        -- Busy day at the office, but still want to fuck? Call Dark Lady's Escorts now. We deliver."""
    ]

    if inof Person.Catgirl then c.push.apply c, [
      """|| bg="Sycamore/WhoreCatgirl1"
        -- ` Heh. Do I want to do what to the bunny? For $100? I'd do that for free. Heheh. She'll never know what hit her.`"""
      """|| bg="Sycamore/WhoreCatgirl2"
        -- ` Mrrrow! So shiny. Want.`"""
      """|| bg="Sycamore/WhoreCatgirl3"
        -- Come on boy, can't you see she's distracted. You'll have to grab her head and facefuck it if you want that cock in her mouth."""
    ]

    if inof Person.Catboy then c.push.apply c, [
      """|| bg="Sycamore/WhoreCatboy1"
        -- Good kitty, just keep purring."""
    ]

    return """|| class="jobStart" auto="1800"
        <h4>Prostitution</h4>
      #{Math.choice c}
        <em><span class="depravity">+#{@depravity}</span>, <span class="resistance">+1</span></em>"""
  effects:
    depravity: 'depravity'
    resistance: 1
