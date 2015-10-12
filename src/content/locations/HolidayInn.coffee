add class HolidayInn extends Place
  name: 'Holiday Inn'
  description: "This place seems to be some sort of inn. It's not really the proper location for a ritual to resurrect me, but Liana suceeded, so I suppose it doesn't matter that much."
  image: 'misc/emptyRoom.jpg'
  jobs: new Collection
  location: [655, 294]
  destinations: new Collection
    HolidayInn: -1

add class Rest extends Job
  place: 'HolidayInn'
  conditions:
    '|events|IntroFuckLiana': {}
  people:
    'Dark Lady': '|people|DarkLady'
    'Liana': '|people|Liana'
  label: 'Mess with Liana'
  text: ->"""While entertaining, it's not, strictly speaking, the most productive thing I can do with a day.

  Liana: <span class="lust">+1 Lust</span></em>
  <em><span class="depravity">+25</span>"""
  next: Page.randomMatch
  @next: []

Job.Rest.next.push add class Rest1 extends Page
  text: ->"""|| bg="Liana/Rip.jpg"
    -- Is it just me, or have her breasts grown a bit? It might be all the recent exposure to lust magic - that has been known to happen.
    --> I spend a few minutes mauling her breasts before moving on to her clit. I give that a good flick, then order her to keep going on her own. She tends to slack off over time, so I have to keep an eye on her and occasionally remind her how hard I want her twisting her own nipples.
      --> <em>Liana: <span class="lust">+1 Lust</span><br><span class="depravity">+25</span></em>
  """
  apply: ->
    super()
    g.people.Liana.add('lust', 1)
  effects:
    depravity: 25

Job.Rest.next.push add class Rest2 extends Page
  text: ->"""|| bg="Liana/Grope.jpg"
    -- What a slut. She starts moaning as soon as I grope her.
    --> Well, to be fair that probably has more to do with the dildo I've had her wearing underneath her panties all day. But still...
    --> `D Slut.`
    --> <em>Liana: <span class="lust">+1 Lust</span><br><span class="depravity">+15</span></em>
  """
  apply: ->
    super()
    g.people.Liana.add('lust', 1)
  effects:
    depravity: 15

add class Raid extends Job
  place: 'HolidayInn'
  type: 'special'
  conditions:
    '|freeSpace': gt: 2
    '|events|Slutroom': {}
    '|events|Raid|length':
      optional: true
      lt: 5
  people:
    'Dark Lady': '|people|DarkLady'
    'Liana': '|people|Liana'
  label: 'Slave raid'
  text: ->"""This inn is a fertile hunting ground. I'm astonished that the keepers haven't bothered us yet, but until they do, I'm perfectly happy to enslave easy victims and take their rooms for my domain."""
  next: Page.firstNew
  @next: []

Job.Raid.next.push add class Raid1 extends Page
  text: ->"""||
    -- `D Ok. Here's what we're going to do. You get them to open the door, lure them into their back room. I'll follow you in fifteen minutes, and take care of them while they're distracted.`
    --> `L How am I supposed to do that, mistress?`
  || bg="Liana/noPants.jpg"
    --> I push her out the door, then gesture at her pants. They disappear. She's not wearing any underwear, of course - she never gets those anymore. `D Use your imagination, dear.`
  || bg="Liana/2guys.jpg"
    -- When I finally arrive to rescue her, Liana has them well... distracted. She's a good girl.
      --> <em class="men">+3</em>
  """
  effects:
    add:
      '|map|HolidayInn|jobs|109': Job.SmallRoom
    men: 3

Job.Raid.next.push add class Raid2 extends Page
  text: ->"""|| bg="Liana/Happy.jpg"
    -- `L I just saw someone check in to room 110. She's really cute, mistress, and we used to be friends. Can we take her? I want to play.`
    --> `L Oh, and... um... she's all alone. I don't think we need to do anything special?`
    --> It's true, none of the embarrassing "distractions" I've asked her to do so far have been actually <em>necessary,</em> though they have been entertaining for me, and that's a pretty good definition of "necessity." Regardless, I pat Liana on the head. `D She's all yours.`

  || bg="Inn/Hogtie.jpg"
    -- I crack the door open a few minutes later to see how Liana's doing with my new slave. She's doing fine.
    --> `L Going home to your family for the weekend, Jamie? No, I don't think so. I think you're going to be a sex slave now. Make fun of my hair, will you...` Liana shoves her onto her back with one foot, and delivers a vicious slap across the breast.
    --> I close the door quietly with a smile. Best give them some more time to get reacquainted.
    --> <em class="women">+1</em>
  """
  effects:
    women: 1
    add:
      '|map|HolidayInn|jobs|110': Job.SmallRoom

Job.Raid.next.push add class Raid3 extends Page
  text: ->"""||
    -- Sometimes, the simplest methods are best.
    --> Find a weak mind, just brimming with desire to experiment for the first time.
    --> Pump in lust magic.
  || bg="Inn/Fisting.jpg"
    --> Collect her and her stronger willed friend while they're distracted, but before the one on top can lose her virginity.
    -- <em class="virgins">+1</em>
    <em class="women">+1</em>
  """
  effects:
    women: 1
    virgins: 1
    add:
      '|map|HolidayInn|jobs|111': Job.SmallRoom

Job.Raid.next.push add class Raid4 extends Page
  text: ->"""||
    -- For once, I'm in the mood to do the dirty work myself. Liana follows on my heels as I head down the hall, looking for an occupied room we haven't taken possession of yet. One door in particular calls out to me, I unlock the door with a touch (these locks are pathetic, nothing like the solid latches or bars I remember from the last time I wandered the world).

  || bg="Inn/Computer.jpg"
    -- Sometimes it's too simple. She's half naked at her desk, chain trailing from her neck, touching herself and moaning.
    --> While I drain her mind, Liana examines the shining box on the table. `L She was talking with her mistress online.`
    --> Slut. She'll be much happier with a real mistress to serve than a crazy magical lightning box.
    --> <em class="women">+1</em>
  """
  effects:
    women: 1
    add:
      '|map|HolidayInn|jobs|112': Job.SmallRoom

Job.Raid.next.push add class Raid5 extends Page
  text: ->"""|| bg="Inn/Cuckold.jpg"
    -- The door opens.
    --> Liana blinks in surprise.
    --> The man blinks in surprise.
  || bg="Slutroom/Oral3.jpg"
    --> His former girlfriend, busy slurping on the pussy I assigned her a few days ago, doesn't notice anyone else in the room.
    -- Before he can say anything, I hit him over the back of the head with a metal cannister. It would have been awkward if he'd screamed, and the girl's busy slurping and shouldn't be distracted, and now I have a bonus slave. Everyone wins.
    --> <em class="men">+1</em>
  """
  effects:
    men: 1

burnChoices = (loc)->
  c = {}
  for key, job of loc.jobs when RoomJob[job.constructor.name]
    c[key] = job.label
  return c

add class Fire extends Job
  place: 'HolidayInn'
  conditions:
    '|events|IntroTakeOver': {}
    '|depravity': gte: 50
    '|location': matches: (l)-> Object.keys(burnChoices l).length
  people:
    'Dark Lady': '|people|DarkLady'
    Liana: '|people|Liana'
  label: 'Fire'
  type: 'special'
  text: ->"""You know what? It's time for some redecorating. Let's release the slaves, set it on fire and build something else.

    I bet Liana will want to watch.

    <em><span class="depravity">-50</span>

    #{dropdown @choices, @choice, 'bottom'}"""
  renderBlock: (mainKey, location)->
    @choices = burnChoices g.map[location]
    @location = location
    unless @choices[@choice]? then @choice = Object.keys(@choices)[0]
    element = $ super(mainKey, location)
    element.on 'change', 'input', =>
      @choice = $('input:checked', element).val()
    return element

add class Fire extends Page
  conditions:
    location: '|last|location'
    choice: '|last|choice'
  text: ->"""||
    -- `L Wait, is... is that a box of matches?`
    --> `D I'm redecorating the #{g.map[@location].jobs[@choice].label}.`
    --> `L Can I smash everything first?`
  ||  bg="Liana/Happy.jpg"
    --> How can I say no to a request like that? I hand her a baseball bat and the box of matches for when she's done.
  || bg="Liana/Fire.jpg"
    -->
    """
  apply: ->
    super()
    type = g.map[@context.location].jobs[@context.choice].constructor.name
    size = RoomJob[type]::size
    room = Job[size.capitalize() + 'Room']
    g.map[@context.location].jobs[@context.choice] = new room
