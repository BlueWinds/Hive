Place.HolidayInn = Game::map.HolidayInn = class HolidayInn extends Place
  name: 'Holiday Inn'
  description: "This place seems to be some port of inn. It's not really the proper location for a ritual to resurect me, but Liana suceeded, so I suppose it doesn't matter that much."
  image: 'misc/emptyRoom.jpg'
  jobs: new Collection
  location: [655, 294]
  destinations: new Collection

Place.HolidayInn::jobs.rest = Job.Rest = class Rest extends Job
  conditions:
    '|events|IntroFuckLiana': {}
  officers:
    'Dark Lady': '|officers|DarkLady'
    'Liana': '|officers|Liana'
  label: 'Mess with Liana'
  text: ->"""While entertaining, it's not, strictly speaking, the most productive thing I can do with a day.

  Liana: <span class="lust">+1 Lust</span></em>
  <em><span class="depravity">+15</span>"""
  next: Page.randomMatch
  @next: []

Job.Rest.next.push Page.Rest1 = class Rest1 extends Page
  text: ->"""|| bg="Liana/Rip.jpg"
    -- Is it just me, or have her breasts grown a bit? It might be all the recent exposure to lust magic - that has been known to happen.
  ||
    --> I spend a few minutes mauling her breasts before moving on to her clit. I give at a good flick, then order her to keep going on her own. She tends to slack off over time, so I have to keep an eye on her and occasionally remind her how hard I want her twisting her own nipples.
  ||
      --> <em>Liana: <span class="lust">+1 Lust</span><br><span class="depravity">+15</span></em>
  """
  apply: ->
    super()
    g.officers.Liana.add('lust', 1)
  effects:
    depravity: 15

Job.Rest.next.push Page.Rest2 = class Rest2 extends Page
  conditions:
    'Dark Lady': {}
  text: ->"""|| bg="Liana/Grope.jpg"
    -- What a slut. She starts moaning as soon as I grope her.
  ||
    --> Well, to be fair that probably has more to do with the dildo I've had her wearing underneath her panties all day. But still...
  ||
    --> #{q @['Dark Lady']}Slut.</q>
  ||
    --> <em>Liana: <span class="lust">+1 Lust</span><br><span class="depravity">+15</span></em>
  """
  apply: ->
    super()
    g.officers.Liana.add('lust', 1)
  effects:
    depravity: 15

Place.HolidayInn::jobs.raid = Job.Raid = class Raid extends Job
  type: 'special'
  conditions:
    '|freeSpace': gte: 2
    '|events|Slutroom': {}
    '|events|Raid|length':
      optional: true
      lt: 5
  officers:
    'Dark Lady': '|officers|DarkLady'
    'Liana': '|officers|Liana'
  label: 'Slave raid'
  text: ->"""This inn is a fertile hunting ground. I'm astonished that the keepers haven't bothered us yet, but until they do, I'm perfectly happy to enslave easy victims and take their rooms for my domain."""
  next: Page.firstNew
  @next: []

Job.Raid.next.push Page.Raid1 = class Raid1 extends Page
  conditions:
    'Dark Lady': {}
    'Liana': {}
  text: ->"""||
    -- #{q @['Dark Lady']}Ok. Here's what we're going to do. You get them to open the door, lure them into their back room. I'll follow you in fifteen minutes, and take care of them while they're distracted.</q>
  ||
    --> #{q @Liana}How am I supposed to do that, mistress?</q>
  || bg="Liana/noPants.jpg"
    --> I push her out the door, then gesture at her pants. They disappear. She's not wearing any underwear, of course - she never gets those anymore. #{q @['Dark Lady']}Use your imagination, dear.</q>

  || bg="Liana/2guys.jpg"
    -- When I finally arrive to rescue her, Liana has them well... distracted. She's a good girl.
  ||
      --> <em class="men">+2</em>
  """
  apply: ->
    super()
    g.men = 3 # Doing this directly, to bypass the space requirements
  effects:
    add:
      '|location|jobs|109': Job.SmallRoom

Job.Raid.next.push Page.Raid2 = class Raid2 extends Page
  conditions:
    'Dark Lady': {}
    'Liana': {}
  text: ->"""|| bg="Liana/Happy.jpg"
    -- #{q @Liana}I just saw someone check in to room 110. She's really cute, mistress, and we used to be friends. Can we take her? I want to play.</q>
  ||
    --> #{q}Oh, and... um... she's all alone. I don't think we need to do anything special?</q>
  ||
    --> It's true, none of the embarrassing "distractions" I've asked her to do so far have been actually <em>necessary,</em> though they have been entertaining for me, and that's a pretty deffiniton of "necessity." Regardless, I pat Liana on the head. #{q @['Dark Lady']}She's all yours.</q>

  || bg="Inn/Hogtie.jpg"
    -- I crack the door open a few minutes later to see how Liana's doing with my new slave. She's doing fine.
  ||
    --> #{q @Liana}Going home to your family for the weekend, Jamie? No, I don't think so. I think you're going to be a sex slave now. Make fun of my hair, will you...</q> Liana shoves her onto her back with one foot, and delivers a vicous slap across the breast.
  ||
    --> I close the door quietly with a smile. Best give them some more time to get reacquanted.
  ||
    --> <em class="women">+1</em>
  """
  effects:
    women: 1
    add:
      '|location|jobs|110': Job.SmallRoom

Job.Raid.next.push Page.Raid3 = class Raid3 extends Page
  text: ->"""||
    -- Sometimes, the simplest methods are best.
  ||
    --> Find a weak mind, just briming with desire to experiment for the first time.
  ||
    --> Pump in lust magic.
  || bg="Inn/Fisting.jpg"
    --> Collect her and her stronger willed friend while they're distracted, but before the one on top can lose her virginity.

  ||
    -- <em class="virgins">+1</em>
    <em class="women">+1</em>
  """
  effects:
    women: 1
    virgins: 1
    add:
      '|location|jobs|111': Job.SmallRoom

Job.Raid.next.push Page.Raid4 = class Raid4 extends Page
  conditions:
    'Dark Lady': {}
    'Liana': {}
  text: ->"""||
    -- For once, I'm in the mood to do the dirty work myself. Liana follows on my heels as I head down the hall, looking for an occupied room we haven't taken posession of yet. One door in particular calls out to me, I unlock the door with a touch (these locks are pathetic, nothing like the solid latches or bars I remember from the last time I wandered the world).

  || bg="Inn/Computer.jpg"
    -- Sometimes it's too simple. She's half naked at her desk, chain trailing from her neck, touching herself and moaning.
  ||
    --> While I drain her mind, Liana examines the shining box on the table. #{q @Liana}She was talking with her mistress online.</q>
  ||
    --> Slut. She'll be much happier with a real mistress to serve than a crazy magical lightning box.
  ||
    --> <em class="women">+1</em>
  """
  effects:
    women: 1
    add:
      '|location|jobs|112': Job.SmallRoom

Job.Raid.next.push Page.Raid4 = class Raid5 extends Page
  conditions:
    'Dark Lady': {}
    'Liana': {}
  text: ->"""|| bg="Inn/Cuckold.jpg"
    -- The door opens.
  ||
    --> Liana blinks in surprise.
  ||
    --> The man blinks in surprise.
  || bg="Slutroom/Oral3.jpg"
    --> His former girlfriend, busy slurping on the pussy I assigned her a few days ago, doesn't notice anyone else in the room.
  ||
    -- Before he can say anything, I hit him over the back of the head with a metal cannister. It would have been awkward if he'd screamed, and the girl's busy slurping and shouldn't be distracted, and now I have a bonus slave. Everyone wins.
  ||
    --> <em class="men">+1</em>
  """
  effects:
    men: 1
