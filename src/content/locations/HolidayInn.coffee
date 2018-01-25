add class HolidayInn extends Place
  name: 'Holiday Inn'
  description: "This place seems to be some sort of inn. It's not really the proper location for a ritual to resurrect me, but Liana succeeded, so I suppose it doesn't matter that much."
  image: 'misc/emptyRoom'
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

  <em>Liana: <span class="lust">+1 Lust</span>
  <span class="depravity">+25</span></em>"""
  next: Page.randomMatch
  @next: []
  apply: ->
    super()
    g.people.Liana.add('lust', 1)
  effects:
    depravity: 25

Job.Rest.next.push add class Rest1 extends Page
  text: ->"""|| bg="Liana/Rip"
    -- Is it just me, or have her breasts grown a bit? It might be all the recent exposure to lust magic - that has been known to happen.
    --> I spend a few minutes mauling her breasts before moving on to her clit. I give that a good flick, then order her to keep going on her own. She tends to slack off over time, so I have to keep an eye on her and occasionally remind her how hard I want her twisting her own nipples.
    --> <em>Liana: <span class="lust">+1 Lust</span>, <span class="depravity">+25</span></em>
  """

Job.Rest.next.push add class Rest2 extends Page
  text: ->"""|| bg="Liana/Grope"
    -- What a slut. She starts moaning as soon as I grope her.
    --> Well, to be fair that probably has more to do with the dildo I've had her wearing underneath her panties all day. But still...
    --> `D Slut.`
    --> <em>Liana: <span class="lust">+1 Lust</span>, <span class="depravity">+25</span></em>
  """

Job.Rest.next.push add class Rest3 extends Page
  text: ->"""|| bg="Liana/Nude"
    -- `D That's what I said. Water's off until you run two laps.`
    --> `L O...outside?!?`
    --> `D You can't very well run laps around the building from the inside, can you? Go.`
    --> <em>Liana: <span class="lust">+1 Lust</span>, <span class="depravity">+25</span></em>
  """

Job.Rest.next.push add class Rest4 extends Page
  text: ->"""|| bg="Liana/Bathroom"
    -- `D You're a very pretty human.`
    --> `L Um, yes mistress, thank you.`
    --> `D I really like the way your breasts sit there, just the perfect size for touching and squeezing.`
    --> `L I, uh...`

    -- Heh. Cute blush. She's way more embarrassed by this than by just being fucked. Compliments as a weak point - who would have though it? `D Stop squirming and sit. Such a cute jawline, it looks so nice wrapped around a cock, especially the way your lips twitch...`
    --> <em>Liana: <span class="lust">+1 Lust</span>, <span class="depravity">+25</span></em>
  """

Job.Rest.next.push add class Rest5 extends Page
  text: ->"""|| bg="Liana/Coat"
    -- `L Thank you, mistress! I had a wonderful day.`
    --> I grumble to myself about her chipper attitude, and debate giving her a good grope. It'd feel nice, and she'd be embarrassed to have it done in public. But no, I decide, not everything needs sex in it.
    --> `L Let's stop and get ice cream on the way home. What's your favorite flavor?`
    --> <em>Liana: <span class="lust">+1 Lust</span>, <span class="depravity">+25</span></em>
  """

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
  || bg="Liana/noPants"
    --> I push her out the door, then gesture at her pants. They disappear. She's not wearing any underwear, of course - she never gets those anymore. `D Use your imagination, dear.`
  || bg="Liana/2guys"
    -- When I finally arrive to rescue her, Liana has them well... distracted. She's a good girl.
      --> <em class="men">+3</em>
  """
  effects:
    add:
      '|map|HolidayInn|jobs|109': Job.SmallRoom
    men: 3

Job.Raid.next.push add class Raid2 extends Page
  text: ->"""|| bg="Liana/Happy"
    -- `L I just saw someone check in to room 110. She's really cute, mistress, and we used to be friends. Can we take her? I want to play.`
    --> `L Oh, and... um... she's all alone. I don't think we need to do anything special?`
    --> It's true, none of the embarrassing "distractions" I've asked her to do so far have been actually <em>necessary,</em> though they have been entertaining for me, and that's a pretty good definition of "necessity." Regardless, I pat Liana on the head. `D She's all yours.`

  || bg="Inn/Hogtie"
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
  || bg="Inn/Fisting"
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

  || bg="Inn/Computer"
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
  text: ->"""|| bg="Inn/Cuckold"
    -- The door opens.
    --> Liana blinks in surprise.
    --> The man blinks in surprise.
  || bg="Slutroom/Oral3"
    --> His former girlfriend, busy slurping on the pussy I assigned her a few days ago, doesn't notice anyone else in the room.
    -- Before he can say anything, I hit him over the back of the head with a metal canister. It would have been awkward if he'd screamed, and the girl's busy slurping and shouldn't be distracted, and now I have a bonus slave. Everyone wins.
    --> <em class="men">+1</em>
  """
  effects:
    men: 1

burnChoices = (loc)->
  c = {}
  for key, job of loc.jobs when RoomJob[job.constructor.name]
    c[key] = job.label
  delete c.BreedingPit
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
    --> `D I'm redecorating the #{g.map[@location].jobs[@choice].label}. Already let the slaves out.`
    --> `L Can I smash everything first?`
  ||  bg="Liana/Happy"
    --> How can I say no to a request like that? I hand her a baseball bat and the box of matches for when she's done.
  || bg="Liana/Fire"
    -->
    """
  apply: ->
    super()
    type = g.map[@context.location].jobs[@context.choice].constructor.name
    size = RoomJob[type]::size
    room = Job[size.capitalize() + 'Room']
    g.map[@context.location].jobs[@context.choice] = new room

add class VisitGym extends Job
  place: 'HolidayInn'
  conditions:
    '|events|SexyGym': {}
    '|map|HolidayInn|jobs|gym': matches: (j)-> j instanceof Job.Gym
  people:
    'Dark Lady': is: Person.DarkLady
    Sadist:
      is: Person.Sadist
    'Sadist ':
      is: Person.Sadist
    'Sadist  ':
      is: Person.Sadist
  type: 'plot'
  label: "A visitor"
  text: ->"""I smell... I smell a bra. In the gym. Someone's getting punished for this, and for once I don't think it's Liana."""

add class VisitGym extends Page
  text: ->"""|| bg="Gym/Treadmills"
    -- Ever since I started exercising my girls there, the gym has been quite popular with the locals. Usually the men, of course, who aren't at all adverse to the fact that some of the sluts like to take their shirts off when it gets too hot.

    For some reason it's quite hard to heat the place up with magic - an 'air conditioner' spell keeps sucking all the heat out. I'll figure it out someday.

    -- Today, though, something is amiss.
    --> `D Her.` I point, and security moves to surround her.
    --> ` Um... I, uh, I'm looking for one of my friends? I think she's here? Can... can you help... eep!` She struggles a little bit as "security" drags her into the back room. Now, how shall I punish her for wearing a bra in my...

  || bg="Gym/VisitCasual"
    -- ` Excuse me, Ms., do you know what just happened?` My my, what a delightful piece of work she is. And not even one of mine!
    --> `D She was not feeling well. I'm just having the doctor take a look at her for a moment,`
    --> ` Oh. She's my friend, I think she was looking for me.`
    --> `D Ah. Well, you're welcome to come back and speak with her if you like. She may be tied up for while.`

  || bg="Gym/VisitFingering1"
    -- We step into one of the gym's back offices, and the friend immediately blushes bright crimson. ` Kateyln?!`
  || bg="Gym/VisitFingering2"
    --> ` A-Amanda? What're you doing here!` Kateyln tries to stand, but a strong hand (and another busy one) from the "doctor" keeps her in place.
    --> They stare at eachother flabbergasted. This is delightful. Amanda just can't seem to move. Kateyln can't help but moan. I grin and watch their increasingly mortified expressions.

  || bg="Gym/VisitGangbang1"
    -- Also, it gives security time to get behind Amanda. One of them throws her onto a bed and rips open her shirt.
    --> `D Amanda. As you well know, there're no bras allowed in the gym. And I can see,` I grope Kateyln's chest, `D You didn't tell your friend. Now you both need to be punished for violating the rules.`
    --> ` Violating the rules? What sort of fucking rule is... Yahhh!`

  || bg="Gym/VisitMortified"
    -- Cocks. Not just fun, also great for shutting up bitches. `D So as I was saying. Amanda, you get superfucked. Kateyln, you knew the rule and let her bring one in anyway. You get fucked.`

  || bg="Gym/VisitGangbang1"
    --> ` Wait, I didn't sign up, I just came to find my friend! What's wrong with you people...`

  || bg="Gym/VisitGangbang2"
    --> Her complaints don't really help her, nor does closing her eyes. She can still hear her friend getting fucked right next to her. Kateyln, on the other hand, can't seem to stop staring in horrified fascination as her friend is violated by three strangers in front of her. I grin and leave them to it.
  """
  effects:
    remove:
      '|map|HolidayInn|jobs|VisitGym': Job.VisitGym

add class LianaConcrete extends Job
  place: 'HolidayInn'
  conditions:
    '|events|Galleria': {}
  people:
    Liana:
      is: Person.Liana
      stuck: true
    'Dark Lady':
      is: Person.DarkLady
  type: 'plot'
  label: "Long-term storage"
  text: ->"""I've been far, far too nice to Liana recently. Let's remind her of her place, shall we?"""
  next: Page.firstNew
  @next: []

Job.LianaConcrete.next.push add class LianaConcrete1 extends Page
  text: ->"""|| bg="Liana/Bathroom"
    -- `L Mistress, hello! I was just getting dressed. What can I do for you?`
    --> `D I've been too nice to you recently. Also, your personal record is only six men in an hour - unacceptable.`
  || bg="Liana/Nude`
    --> `L Um...` She pulls a towel up around to cover her nudity. I laugh and grab her by the hair.
    --> `D You won't need that where you're going. Come.`

  || bg="Galleria/Wall4"
    -- I lead her to the Galleria, tugging on her hair occasionally to remind her that she's mine, and never letting her fully catch up with my quick pace. We stop at the front desk, and I take away her towel.
    --> `Now, relax and don't resist. If you resist, I'll have to squeeze harder, and that'll make your final position less comfortable.`
    --> She is understandably nervous, but does her best to relax. I give her a smile, though it probably comes across as more predatory than reassuring.

    -- I set my spell in motion. The air grows thick with magic, shimmering in a sphere around her. It tugs on Liana, changing her position, and heeding my words she doesn't resist.
  || bg="Liana/Exposing`
    --> The magic grows thicker, and she floats up into the air, drifting backwards. She doesn't notice when her elbows reach the concrete wall behind her, but just continues drifting backwards, passing straight through it. Finally, with a loud pop, her body snaps back into solidity.
  || bg="Liana/Concrete`
    `L I... what!?`
    -->I grin and flick her clit harshly. `D You can come out when you've been used 600 times. Get to it.`
  """

Job.LianaConcrete.next.push add class LianaConcrete2 extends Page
  text: ->"""|| bg="Liana/Concrete"
    -- `L Oww, oww, oww,` Liana's howls attract considerable laughter from the rest of the line waiting to use her as a woman tugs on her nipple savagely. The woman's other hand is buried in Liana's cunt, twisting and thrusting its way until she can feel fingers brushing her cervix. `L Oh god, that's... I can't take... any more,` Her panting is, of course, ignored. She's here for their amusement, not her own.
  """

Job.LianaConcrete.next.push add class LianaConcrete3 extends Page
  text: ->"""|| bg="Liana/ConcreteDone"
    -- `L Oh, fuck, come on, rub my clit, please? I haven't cum in four hours, please, I'm begging you... Ah!`
    --> The man cums inside her. Stuck in the wall, Liana can do no more than beg for release. A rare few grant her wish, but most either ignore her pleas or use her mouth in order to shut her up.
  """

Job.LianaConcrete.next.push add class LianaConcrete4 extends Page
  text: ->"""|| bg="Liana/ConcreteDone"
    -- `D So, how are you feeling, Liana? That was the 600th.`
    --> It takes her a moment to focus on me. She's been fucked, abused, cummed in, cummed on, called names nearly continually for 4 days now. She's had men in her cunt, men in her ass, men in her mouth. She's had her breasts caressed, slapped, pinched and drawn on. No one has cleaned the cum from her - it oozes from every hole, covers her skin, pools in a puddle on the floor beneath her. I don't blame her for being a little slow.
    --> `L Mistress. Hullo. I only... I only thought that was 562.`
    -- `D Some of them used you while you were passed out.`
    --> `L Oh. Well. Maybe those shouldn'st count?`
    --> `D You really are a slut, aren't you.` I chuckle, and kiss her on the lips. A rare honor. I can taste the thick mix of cum coating her. `D Very well. A few more hours.`
  """
  effects:
    remove:
      '|map|HolidayInn|jobs|LianaConcrete': Job.LianaConcrete

add class TheEnd extends Job
  place: 'HolidayInn'
  conditions:
    '|events|LianaConcrete': {}
    '|events|VisitGym': {}
    '|events|DormDaily': {}
    '|events|BlackmailOfficer2': {}
    '|events|Nudity': {}
    '|events|ProfessorsOrdeal11': {}
    '|events|LianaTeleport': {}
    '|events|TrainingFacilityGraduate': {}
    '|events|TheEnd': false
  people:
    Liana:
      is: Person.Liana
    'Dark Lady':
      is: Person.DarkLady
  type: 'plot'
  label: "The end (???)"
  text: ->"""Having explored what this new world has to offer, it's time to consider my next moves. Liana, get in here."""

add class TheEnd extends Page
  text: ->
    j = g.map.Research.jobs
    research = Object.keys(j).length
    researchUndone = Object.keys(j).filter((k)-> j[k]).map((k)-> j[k].label)

    rooms = Object.keys(Place.Rooms::jobs).filter((k)-> not k.match('LeaveEmpty'))
    roomsUnbuilt = rooms.filter((k)-> not g.events[k]).map((k)-> Place.Rooms::jobs[k]::label)

    return """
  || bg="Inn/Pentagram"
    -- Magic. It flows through me. I'm not what I once was, but neither am I any more the troubled, pitiful version of myself that Liana summoned so many months ago. I'm strong enough now that tearing a door in reality is no trouble. I step through one fold, and grab a startled Liana's hand. Another step, and we're both elsewhere.
  || bg="Liana/Rooftop"
    --> The big city. It stretches away from us, resplendant in the setting sun.`D Ssh,` I hold a finger to her lips as she starts to say something, perhaps to ask why I've brought us here.
    --> She waits silently while I consider what to say.

    -- `D I once promised you revenge on the Dean's office.`
    --> `L Huh, you remember that?`
    --> `D Of course. It's the only term of our pact unfulfilled.`
    --> `L I... it's not as important to me as it once was.` She shakes her head. `L Um... if I release you from the terms, what will you do?`
  || bg="Liana/Magic"
    -- I smirk. `D Release me? Silly girl.` Her hand jerks up, lays itself across her cheek. She's not controlling it - I am.
    --> `D You are mine.` I stand, and force her body to relax completely.
    --> `D My body, my mind.` She stares at me with mingled horror and desire as I move towards her. I can feel her heart pounding in her chest. Her magic stirs, but it's of no consequence. My hooks are set deep.
    --> `D My soul.`

    -- I step forward and plant a kiss on her forehead.
  || bg="Liana/Rooftop"
    --> `D Somehow, I too find things not as important to me as they once were.`
    --> I sit down next to her, staring at the city, and relax my control. She doesn't move for a moment, then shifts a little closer to my side. Our shoulders touch.
    --> It's been a long time since I've let someone get so close.

    -- <em>You've reached the end of Hive's story (such as it is). Congrats! Feel free to continue exploring and enjoying things as long as you like - there's likely at least a few variations of daily events you haven't encountered yet.</em>
    <em>#{if roomsUnbuilt.length then "You haven't built the " + roomsUnbuilt.wordJoin() + '.' else "You've constructed all building types."}</em>
    <em>#{if researchUndone.length then "You haven't researched " + researchUndone.wordJoin() + '.' else "You've researched everything."}</em>
  """
  effects:
    depravity: -800
    add:
      '|map|NorthEnd|jobs|7': Job.LargeRoom
    remove:
      '|map|Council|jobs|Nudity': Job.Nudity
