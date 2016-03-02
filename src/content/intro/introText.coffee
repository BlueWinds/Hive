Page.Intro = class Intro extends Page
  text: ->"""||
    --| <center>Tired.</center>
    --> <center>I'm tired.</center>
    --> <center>There's also pain, but that's secondary compared to the all-consuming lethargy that holds my limbs down on the cold floor.</center>
    --> <center>A floor. Why am I on the floor? I should be...</center>
    --> <center>I'm not sure where I should be. But the floor isn't it. Something's wrong, missing...</center>
    --> <center>My magic. I can barely feel it, a weak, pathetic little tendril of power when it should be an all-consuming serpent coiling about me.</center>
    --> <center>I try to speak, but my voice is as weak as my magic, and all that comes out is a cough. It's pathetic.</center>
    --> <center>But even as shriveled as my power is, it's still more than enough that I needn't appear so weak in front of the other person in the room, who I can now hear muttering to herself and fussing about.</center>
  || speed="slow" bg="misc/emptyRoom"
    -- Pouring power into my limbs, I manage sit up and open my eyes.
    --> The room is... boring. That's the only way to describe it.
    --> What was once white paint peeling off the walls. A messy bed, covered with some sort of folded paper boxes smudged with food.
  || bg="Inn/Pentagram"
    --> I sit inside a ritual circle, surrounded by candles and chalk lines. It hurts to look at, and I literally cannot even think of reaching outside it.

    -- If I were feeling better, I could shatter this crude binding with a thought, but I'm not. I'm tired and hungry and weak.
  || bg="Liana/Happy"
    --> Instead I focus on the final item in the room. A woman. Disheveled, long black hair lank with sweat, her arms shaking with exhaustion as she rests on the floor."
    --> Her face is alive though, the moment she opens her eyes, filled with triumph. She's staring at me. I'm naked, of course, which is only natural, but that's not why she's staring.
    --> `D Speak.`
"""
  apply: ->
    g.location = g.map.HolidayInn
    super()

Page.Intro::next = Page.Intro2 = class Intro2 extends Page
  text: ->"""|| bg="Liana/Happy"
    -- She starts at the sound of my voice, smacking her head against the bed behind her. It takes a moment of scrambling before she brushes hair out of her face, and another moment before she manages to obey my command.
    --> `L Welcome to the mortal realm, ma'am. I... um, I wasn't sure that you actually existed.` She giggles, grinning at her own audacity, then clears her throat and goes on.
    --> `L If it would please you, I would like to make a bargain.`

    -- Liana. I know her name without being told.
    --> Feeble as it is, my magic can still draw facts like that from her mind without thought. Her attitude is pleasant, a mixture of excitement and fear - the first pleasant thing to happen since I awoke bound to the floor by magic.

    -- `D Call me mistress.`
    --> `L You are not my mistress. Not yet, at least.`
    --> She has some spine after all. Even better. If I were stronger... a useless thought. I banish it. After a moment of silence, I nod.
    --> `D Very well. What bargain do you wish to strike with the Dark Lady?`

    -- `L I've summoned you to the mortal world, but the spell will only hold as long as I give it power.`
    --> `L I'll hold it until you can maintain it yourself, and I'll free you. In return, I want to be the first among your lieutenants. Hold no one above me.`
    --> I quirk an eyebrow, waiting for her to continue. She doesn't disappoint.
    --> `L And I want the Dean's office at the University as my absolute slaves, to dispose of as I see fit.`

    -- She has a malicious gleam in her eye that I find absolutely delightful. I like this Liana better by the moment. I can feel her power too - though much of it is tied up anchoring me in reality, there's <em>still</em> enough left to be impressive for a human.
    --> `D I accept.`

  || bg="Inn/Pentagram"
    -- Without hesitation she reaches forward and smudges one of the lines of the pentagram.
    --> I'm free.
    --> The world shall tremble.
    --> <em>My</em> world.
"""
  next: Page.Port

Place.HolidayInn::jobs.introLiana = Job.IntroFuckLiana = class IntroFuckLiana extends Job
  people:
    'Dark Lady': '|people|DarkLady'
    Liana: '|people|Liana'
  type: 'plot'
  label: 'Fuck Liana'
  text: ->"""It's been too long since I had a good lay. Being dead for a few millennia really puts a fire in one's loins."""

Job.IntroFirstSlaves = class IntroFirstSlaves extends Job
  people:
    'Dark Lady': '|people|DarkLady'
    Liana: '|people|Liana'
  type: 'plot'
  label: 'Explore the area'
  text: ->"""While it's fun messing with my first slave, it's really time to get moving."""

Job.IntroFuckLiana::next = Page.IntroFuckLiana = class IntroFuckLiana extends Page
  text: ->"""|| bg="Liana/Happy"
    -- I've been... well, if not precisely <i>dead</i>, at least something pretty close for quite some time. And since she's just pledged herself to me...
  || bg="Liana/Grope"
    --> I reach a hand up underneath her shirt, expecting to grope her breasts roughly, and encounter something covering them.
    --> She grasps my wrist, and I ignore her surprised look, exploring the fabric she has on underneath.
    --> It's springy. Her shirt stretches too, most unnaturally. I frown at her.

    -- In my quest after her breasts, I'm briefly distracted by writing and an image on her shirt. "Nightwish." Hm? Who's wishing for what at night?
  || bg="Liana/Bra"
    --> Dismissing the markings as unimportant, I rip it off her body.
    --> `L Hey! That was my favorite t-shirt. You can't just... mmmgph!`
    --> I grab her by the throat and grin, shutting her up for now.

    -- The undergarment still covers her breasts.
    --> It's stretchy.
    --> It stymied my efforts to grope her.
    --> It'll have to go.

    -- I poke it.
    --> It's black, and I hate it.
    --> Yes, it's a piece of cloth, but I'm a Dark Lady, and I can demand eternal suffering for a piece of cloth if I so desire.

    -- `D I can do anything I want. You, however, may not. You are never again to wear another one of these disgusting things in my presence. What do you call it?`
    --> `L A... a bra, mistress.`
  || bg="Liana/Rip"
    --> I rip it off with the other hand and let her slide to the floor. It's a good thing she was too surprised to resist - as things are right now, she's probably stronger than I am.
    --> Even if she's pledged to my service, it would just be embarrassing if a servant overpowered me. I sneer at the \"bra\" and conjure a burst of flame to consume it. I can still do that much at least.

    -- `D A bra. You are never to wear a bra again. Now, get naked.`
    --> <em class="depravity">+25</em><br><em>Dark Lady: <span class="strength">+2 Strength</span></em><br><em>Liana: <span class="lust">+1 Lust</span></em>
"""
  apply: ->
    super()
    L.add('lust', 1)
    D.add('strength', 2)
  effects:
    depravity: 25
    remove:
      '|location|jobs|introLiana': Job.IntroFuckLiana
    add:
      '|location|jobs|introFirstSlaves': Job.IntroFirstSlaves

Job.IntroFirstSlaves::next = Page.IntroFirstSlaves = class IntroFirstSlaves extends Page
  text: ->"""||
    -- As much fun as I've been having driving Liana into exhaustion (I wouldn't have believed she could fit that glass bottle up her ass, but, well... The girl is talented, what can I say?), it's time to stop playing around and get to work.
    --> I cradle her face gently in my hands and wake her up with a kiss. I liked her before, but I like her even better now that she's properly nude and sitting at my feet, rather than standing eye to eye.
  || bg="Liana/Insertion"
    --> `D Time to get to work, dear. No, not the toy, leave that there, that's a good girl.`

    -- `D Tell me about this kingdom. They seem quite wealthy, if even a rude hovel like this can afford its own ice chest. I hope this isn't an a far northern land?`
    --> She blinks several times, as though I've said something incredibly foolish. I don't see why - I hate the cold.
    --> `L This isn't a kingdom, mistress. And everyone has a freezer. Um... look, maybe we can just leave that aside for now. What we really need to worry about is money. I've paid for another three days, but after that, my cards are maxed out, and I don't think you have a bank account.`
    --> I laugh. She looks so earnest, worrying about such a thing. And cute, too, with her breasts bobbing and cunt still dripping occasionally. I must be getting soft.

  || bg="Liana/Happy"
    -- We spend the next several hours going over a bit of local history and geography. "California" seems to be just one kingdom in a larger empire, the Yousa. But we're in a small, isolated town which might as well just be begging for conversion into my new stronghold. A couple of foreign wars, but nothing local. Perfect.
    --> I don't like those things called "cars," though, that she assures me everyone has. The local constables might be able to summon the king's army within a few days. Then they'd burn all my tentacle gardens and lock me up and make me wear a bra in prison. That would be terrible.

  || bg="none"
    -- The first step, however, is clear enough. I need to establish a magical center, and to do that, I'll need some slaves. Liana's too valuable for that duty, and still needed to keep me from fading out of existence besides.
    --> Liana is a mage. I am a Dark Lady. We're staying in an inn (quite a large one, in fact). The task is trivial. I make one of the walls translucent to sight, then once we locate our targets, I rotate it out of existence entirely.

  || bg="Inn/Sleepover"
    -- She steps though, startling my new slaves. One of the women opens her mouth to scream, but Liana doesn't balk, as I half expected her to, and cuts the girl off with a spell. Both of my new slaves collapse into a deep slumber. They won't wake up until we have a use for them. She steps into another room, and I hear her repeat the same spell.
    --> She borrows one of their voices, and speaks to a machine on the bedside table, then informs me that the room is now ours to for the rest of the week.

  || bg="Liana/Happy"
    -- `D Mine, silly girl. Not ours.`
    --> I do pat her on the head though. She can't decide if she should be happy or demeaned by the act. Both emotions are appropriate, I reassure her.
    --><em class="virgins">+1 Virgin</em><br><em class="women">+2 Women</em>
"""
  apply: ->
    super()
    # Do this here rather than in "effects" to bypass the normal dungeon limit on free slaves.
    g.virgins = 1
    g.women = 2
  effects:
    remove:
      '|location|jobs|introFirstSlaves': Job.IntroFirstSlaves
    add:
      '|location|jobs|107': Job.SmallRoom
      '|location|jobs|108': Job.SmallRoom

Place.HolidayInn::jobs.introTakeOver = Job.IntroTakeOver = class IntroTakeOver extends Job
  conditions:
    '|people|0': {}
  people:
    'Dark Lady': '|people|DarkLady'
    Liana: '|people|Liana'
  type: 'plot'
  label: 'Conquest'
  text: ->"""I'm rather tired of the fact that my slaves have to put on clothes to move between rooms. Honestly, it's embarrassing how long it's taking me to conquer just one building."""

Job.IntroTakeOver::next = Page.IntroTakeOver = class IntroTakeOver extends Page
  text: ->"""|| bg="Liana/Happy"
    -- `D Come, Liana, it's time to cease hiding in the shadows. Take me to the innkeeper so we can stop your ridiculous fretting about money.`
    --> `L Do you want to go to him, or shall I give him a call?`
    --> I blink. She's a smarty, this one is. Less chance of any witnesses if he comes to us. But no, I'm tired of being cooped up in this room. I do grumble a bit as I pull on clothes. Though Liana has nothing that fits properly, at least one of her "T shirts" can stretch to cover my more ample bosom.

  || bg="Inn/FrontDesk"
    -- "Hello! Welcome to Holiday Inn. Liana, right? I'm glad you decided to stay with us a few extra days. Is there anything I can help with?"
    --> `D You can become my sex slave. I am taking over this establishment.`
  || bg="Inn/FrontDeskBlush"
    --> "Um..."
    --> I grin, and hit her with a wave of lust and obedience. Naturally, she blushes deeper and starts drooling over everyone in sight, lower lip trembling as she starts to strip.

  || bg="Inn/FrontDeskBra"
    -- The air in the room freezes. I glare at her. Everyone holds their breath as my face twists into a sneer. She's. Wearing. A. A...
    --> `D Liana, what is that thing called again?`
    --> `L A bra, mistress.`

    --> `D Right. A bra.`
    -- `D You, slave, she's not to be without a cock inside her for twenty four hours.` I order one of my male slaves to attend to her. `D After that, you, bra-girl, return to the front desk. This place is closed for repairs until further notice. No more customers, but keep everything running like normal.`
    --> `D You can keep your shirt, since you'll be dealing with the outside world, but while you're behind that counter, no pants or underwear, ever.` Since I haven't actually mind controlled her, just added a hint of obedience and a pound of not-telling-anyone, I back my commands up with a threat. `D Anyone catches you with pants on inside this room, I'll make you work topless too.`

    -- Liana, perhaps sensing that I'm liable to keep ranting and raving and piling punishments on the hussy as long as that... thing... remains in my sight, banishes the bra with a spell.
  || bg="Inn/FrontDeskSex"
    --> I nod to the slave to begin her fucking. The Holiday Inn is mine. I can set up some <em>proper</em> facilities inside it now, and send slaves into the outer world.
    -- <em>New location: <b>Sycamore Street</b></em>
    """
  effects:
    add:
      '|location|jobs|gym': Job.Gym
      '|location|jobs|113': Job.SmallRoom
      '|location|jobs|115': Job.MediumRoom
      '|location|jobs|116': Job.MediumRoom
    remove:
      '|location|jobs|introTakeOver': Job.IntroTakeOver
  apply: ->
    super()
    g.map.HolidayInn.destinations.Sycamore = -1

add class Council extends Job
  place: 'HolidayInn'
  conditions:
    '|events|Tunnel2': {}
    '|events|Council': false
  type: 'plot'
  people:
    'Dark Lady': '|people|DarkLady'
    'Liana': '|people|Liana'
  label: 'City Council'
  text: ->"""I am tired of evading the police and keeping a low profile. I have the power now to fix things."""

add class Council extends Page
  text: ->"""|| bg="Liana/Happy"
    -- `L I am happy to serve, mistress. I was hesitant at first - you know how often demons like to talk about taking over the world, and how seldom they actually manage more than getting killed within the first few weeks...`
    --> `D I'm not a demon, as you well know by now.`

    --> `L Oh, of course not, mistress. Just explaining why I didn't want to go straight for the throat, as it were. Anyway, the city council meets once a week, and if you lend me some magic, it should be simple enough to wring special concessions out of them...`
    -- <em>New location: <b>City Council</b></em>
  """
  apply: ->
    super()
    g.map.HolidayInn.destinations.Council = -1

add class MoreResources extends Job
  place: 'HolidayInn'
  conditions:
    '|events|Galleria': {}
  people:
    'Dark Lady': is: Person.DarkLady
    Liana: is: Person.Liana
  type: 'plot'
  label: "Expansion"
  text: ->"""Now that my little "operation" is stable, it's time to start looking into real power. That means more magic."""

add class MoreResources extends Page
  text: ->"""|| bg="Inn/Pentagram"
    -- I don't want to be chained to Liana forever. In addition to all the things that can go wrong with a frail human (not that she's particularly frail, mind you, anything but), as long as she's busy anchoring me to the world, I'm limited by her magic, and her magic is limited by me.

    She needs another few years to grow into her power, but when the time comes... the ritual to stop aging is difficult enough as is. I think she'll be powerful enough, but not if I'm tying up three quarters of her magic.

    --> Anyway, distractions. It's time to start my minions collecting milk and cum, since the ley-lines in this part of the world are pathetically weak. Time for more research!
  """
  apply: ->
    super()
    g.milk = 0
    g.cum = 0
  effects:
    remove:
      '|map|HolidayInn|jobs|MoreResources': Job.MoreResources

add class Tentacles extends Job
  place: 'HolidayInn'
  conditions:
    '|events|MagicCircle': {}
  people:
    'Dark Lady':
      is: Person.DarkLady
      label: -> if D.magic >= 30 then 'Dark Lady' else 'Dark Lady (<span class="magic">30+</span>)'
      matches: (p)-> p.magic >= 30
    Liana: is: Person.Liana
  type: 'plot'
  label: "A Serious Talk"
  text: ->"""There is something I must discuss with Liana."""
  next: Page.firstNew
  @next: []

Job.Tentacles.next.push add class Tentacles1 extends Page
  text: ->"""|| bg="Liana/Happy"
    -- `D Liana dear. Sit.`
    --> She sits, fidgeting nervously. `L Um... did I do something...`
    --> `D No, you're been a very good girl. But...` I hate myself right now. I don't know how to do this. I put a hand to my forehead and rub it. Isn't that mortals do when they're at a loss? I'm making Liana nervous. She's never seen me pace before. Have I ever paced before? I don't think so.

  || bg="Inn/Pentagram"
    -- `D There is something very wrong with the world. I recently regained enough power to teleport, and I've been...`
    --> `L That's a thing you can do? Can I do that?`
    --> `D Yes, you're easily powerful enough. I'll show you later. But the point is, I've been exploring. It appears that you and I are the most powerful magical beings in the world.`
    --> She doesn't get it. She can hear how much that bothers me, but she doesn't know why. Leana puts a hand on my forearm. I'm pathetic, to be reassured by contact with a human. I brush her arm off.

    -- `D I've been intensely cautious in my approach, because by all rights we ought to have holy crusaders knocking down our doors by now, and I wanted to seem nothing more than a succubus or some such minor nonsense. But where are the gods and demon lords and sorcerers and saints? I can't find them. I don't know why. Clearly magic still works. There's you, the amulet that can resist you, some of the slaves have minor talents. But the world used to be swimming in magic, and all that's left are fragments.`

  || bg="Liana/Crying"
    --> She's crying. Damn it. Of course I hadn't told her any of what has been bothering me - she's just a slave, even if a pretty one. I rub my hand on my forehead again. `D Look. I don't know where the gods are - I lost that war, but they're not here and I am. So I'm going to take over the world, and give you your revenge and any other little treats you like along the way. But it's only fair you know that I'm a bit confused, and I don't mean just the absurd complexity of your tell-a-visions.`"""

Job.Tentacles.next.push add class Tentacles2 extends Page
  text: ->"""||
    -- `L Mistress? May I speak with you?`
  || bg="Liana/Kneeling"
    --> I gesture her to my side, and she kneels obediently on the floor, hands folded in her lap waiting for me to acknowledge her presence. To anyone else it might look like I'm just staring off into thin air, but she can feel the forces moving around me. This is delicate work. I finish a mental component of the spell, leave it hanging there and turn my attention to her as I continue to feed it power.

    -- `L I've been thinking about what you said, about where all the magic is, and... well, you're always saying what a powerful mage I am, but I wasn't, not until I met you. Summoning you was the first thing I was ever able to do, and I've just been getting stronger since then... well, anyway, I don't think there is magic in the world, I think it's just you and I was lucky to be nearby when you arrived.`
    --> So that's what's been bothering her. She's been quiet ever since I spoke with her last time. `D Potential is inborn. I can't empower anyone else beyond very strict limits, defined from birth. You are... you are unusual, for a human, let's just leave it at that. If you'd been useless like most of the toys around here, I'd have corrupted your mind and broken the contract long ago.`

    -- `D Don't look so shocked. You're my second because I chose you, not because of some silly contract you tried to force on me.`
    --> `L Uh. Um. I... I didn't... About the lack of magic...`
    --> `D Forget about it. Not important. Here, catch.` I throw the almost-complete spell in her direction. She reaches out to catch the ball of tightly woven power with her bare hands.

  || bg="Liana/Tentacles"
    -- Silly girl. Don't try to catch magic with your hands.
    --> `D I've finally managed to summon one in its natural, long-lived form.`
  || bg="Cocoon/Build2"
    --> `D We should install him in one of the warehouses in North End... Are you even listening? Pay attention Liana, this is important.`"""
  apply: ->
    super()
    g.tentaclesReady = true
  effects:
    remove:
      '|map|HolidayInn|jobs|Tentacles': Job.Tentacles
    add:
      '|map|NorthEnd|jobs|4': Job.LargeRoom
      '|map|NorthEnd|jobs|5': Job.SmallRoom
      '|map|NorthEnd|jobs|6': Job.SmallRoom
