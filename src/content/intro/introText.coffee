Page.Intro = class Intro extends Page
  conditions:
    DarkLady: '|officers|DarkLady'
  text: ->"""||
    --| <center>Tired.</center>
  ||
    --> <center>I'm tired.</center>
  ||
    --> <center>There's also pain, but that's secondary compared to the all-consuming lethargy that holds my limbs down on the cold floor.</center>
  ||
    --> <center>A floor. Why am I on the floor? I should be...</center>
  ||
    --> <center>I'm not sure where I should be. But the floor isn't it. Something's wrong, missing...</center>
  ||
    --> <center>My magic. I can barely feel it, a weak, pathetic little tendril of power when it should be an all-consuming serpent coiling about me.</center>
  ||
    --> <center>I try to speak, but my voice is as weak as my magic, and all that comes out is a cough. It's pathetic.</center>
  ||
    --> <center>But even as shriveled as my power is, it's still more than enough that I needn't appear so weak in front of the other person in the room, who I can now hear muttering to herself and fussing about.</center>

  || speed="slow" bg="misc/emptyRoom.jpg"
    -- Pouring power into my limbs, I manage sit up and open my eyes.
  ||
    --> The room is... boring. That's the only way to describe it.
  ||
    --> What was once white paint peeling off the walls. A messy bed, covered with some sort of folded paper boxes smudged with food.
  || bg="Inn/Pentagram.jpg"
    --> I sit inside a ritual circle, surrounded by candles and chalk lines. It hurts to look at, and I literally cannot even think of reaching outside it.

  ||
    -- If I were feeling better, I could shatter this crude binding with a thought, but I'm not. I'm tired and hungry and weak.
  || bg="Liana/Happy.jpg"
    --> Instead I focus on the final item in the room. A woman. Disheveled, long black hair lank with sweat, her arms shaking with exhaustion as she rests on the floor."
  ||
    --> Her face is alive though, the moment she opens her eyes, filled with triumph. She's staring at me. I'm naked, of course, which is only natural, but that's not why she's staring.
  ||
    --> #{q @DarkLady}Speak.</q>
"""
  apply: ->
    g.location = g.map.HolidayInn
    super()

Page.Intro::next = Page.Intro2 = class Intro2 extends Page
  conditions:
    DarkLady: {}
    Liana: '|officers|Liana'
  text: ->"""|| bg="Liana/Happy.jpg"
    -- She starts at the sound of my voice, smacking her head against the bed behind her. It takes a moment of scrambling before she brushes hair out of her face, and another moment before she manages to obey my command.
  ||
    --> #{q @Liana}Welcome to the mortal realm, ma'am. I... um, I wasn't sure that you actually existed.</q> She giggles, grinning at her own audacity, then clears her throat and goes on.
  ||
    --> #{q @Liana}If it would please you, I would like to make a bargain.</q>

  ||
    -- Liana. I know her name without being told.
  ||
    --> Feeble as it is, my magic can still draw facts like that from for mind without thought. Her attitude is pleasant, a mixture of excitement and fear - the first pleasant thing to happen since I awoke bound to the floor by magic.

  ||
    -- #{q @DarkLady}Call me mistress.</q>
  ||
    --> #{q @Liana}You are not my mistress. Not yet, at least.</q>
  ||
    --> She has some spine after all. Even better. If I were stronger... a useless thought. I banish it. After a moment of silence, I nod.
  ||
    --> #{q @DarkLady}Very well. What bargain do you wish to strike with the Dark Lady?</q>

  ||
    -- #{q @Liana}I've summoned you to the mortal world, but the spell will only hold as long as I give it power.</q>
  ||
    --> #{q @Liana}I'll hold it until you can maintain it yourself, and I'll free you. In return, I want to be the first among your lieutenants. Hold no one above me.</q>
  ||
    --> I quirk an eyebrow, waiting for her to continue. She doesn't disappoint.
  ||
    --> #{q @Liana}And I want the Dean's office at the University as my absolute slaves, to dispose of as I see fit.

  ||
    -- She has a malicious gleam in her eye that I find absolutely delightful. I like this Liana better by the moment. I can feel her power too - though much of it is tied up anchoring me in reality, there's <em>still</em> enough left to be impressive for a human.
  ||
    --> #{q @DarkLady}I accept.

  || bg="Inn/Pentagram.jpg"
    -- Without hesitation she reaches forward and smudges one of the lines of the pentagram.
  ||
    --> I'm free.
  ||
    --> The world shall tremble.
  ||
    --> <em>My</em> world.
"""
  next: Page.Port

Place.HolidayInn::jobs.introLiana = Job.IntroFuckLiana = class IntroFuckLiana extends Job
  officers:
    'Dark Lady': '|officers|DarkLady'
    Liana: '|officers|Liana'
  type: 'plot'
  label: 'Fuck Liana'
  text: ->"""It's been too long since I had a good lay. Being dead for a few millenia really puts a fire in one's loins."""

Job.IntroFirstSlaves = class IntroFirstSlaves extends Job
  officers:
    'Dark Lady': '|officers|DarkLady'
    Liana: '|officers|Liana'
  type: 'plot'
  label: 'Explore the area'
  text: ->"""While it's fun messing with my first slave, it's really time to get moving."""

Job.IntroFuckLiana::next = Page.IntroFuckLiana = class IntroFuckLiana extends Page
  conditions:
    'Dark Lady': {}
    Liana: {}
  text: ->"""|| bg="Liana/Happy.jpg"
    -- I've been... well, if not precisely <i>dead</i>, at least something pretty close for quite some time. And since she's just pledged herself to me...
  || bg="Liana/Grope.jpg"
    --> I reach a up underneath her shirt, expecting to grope her breasts roughly, and encounter something covering them.
  ||
    --> She grasps my wrist, and I ignore her surprised look, exploring the fabric she has on underneath.
  ||
    --> It's springy. Her shirt stretches too, most unnaturally. I frown at her.

  ||
    -- In my quest after her breasts, I'm briefly distracted by writing and an image on her shirt. "Nightwish." Hm? Who's wishing for what at night?
  || bg="Liana/Bra.jpg"
    --> Dismissing the markings as unimportant, I rip it off her body.
  ||
    --> #{q @Liana}Hey! That was my favorite t-shirt. You can't just... mmmgph!</q>
  ||
    --> I grab her by the throat and grin, shutting her up for now.

  ||
    -- The undergarment still covers her breasts.
  ||
    --> It's stretchy.
  ||
    --> It stymied my efforts to grope her.
  ||
    --> It'll have to go.

  ||
    -- I poke it.
  ||
    --> It's black, and I hate it.
  ||
    --> Yes, it's a piece of cloth, but I'm a Dark Lady, and I can demand eternal suffering for a piece of cloth if I so desire.

  ||
    -- #{q @['Dark Lady']}I can do anything I want. You, however, may not. You are never again to wear another one of these disgusting things in my presence. What do you call it?</q>
  ||
    --> #{q @Liana}A... a bra, mistress.</q>
  || bg="Liana/Rip.jpg"
    --> I rip it off with the other hand and let her slide to the floor. It's a good thing she was too surprised to resist - as things are right now, she's probably stronger than I am.
  ||
    --> Even if she's pledged to my service, it would just be embarrassing if a servant overpowered me. I sneer at the \"bra\" and conjure a burst of flame to consume it. I can still do that much at least.

  ||
    -- #{q @['Dark Lady']}A bra. You are never to wear a bra again. Now, get naked.</q>
  ||
    --> <em class="depravity">+25</em><br><em>Dark Lady: <span class="strength">+2 Strength</span></em><br><em>Liana: <span class="lust">+1 Lust</span></em>
"""
  apply: ->
    super()
    @context.Liana.add('lust', 1)
    @context['Dark Lady'].add('strength', 2)
  effects:
    depravity: 25
    remove:
      '|location|jobs|introLiana': Job.IntroFuckLiana
    add:
      '|location|jobs|introFirstSlaves': Job.IntroFirstSlaves

Job.IntroFirstSlaves::next = Page.IntroFirstSlaves = class IntroFirstSlaves extends Page
  conditions:
    'Dark Lady': {}
    Liana: {}
  text: ->"""||
    -- As much fun as I've been having driving Liana into exhaustion (I wouldn't have believed she could fit that glass bottle up her ass, but, well... The girl is talented, what can I say?), it's time to stop playing around and get to work.
  ||
    --> I cradle her face gently in my hands and wake her up with a kiss. I liked her before, but I like her even better now that she's properly nude and sitting at my feet, rather than standing eye to eye.
  || bg="Liana/Insertion.jpg"
    --> #{q @['Dark Lady']}Time to get to work, dear. No, not the toy, leave that there, that's a good girl.</q>

  ||
    -- #{q @['Dark Lady']}Tell me about this kingdom. They seem quite wealthy, if even a rude hovel like this can afford its own ice chest. I hope this isn't an a far northern land?</q>
  ||
    --> She blinks several times, as though I've said something incredibly foolish. I don't see why - I hate the cold.
  ||
    --> #{q @Liana}This isn't a kingdom, mistress. And everyone has a freezer. Um... look, maybe we can just leave that aside for now. What we really need to worry about is money. I've paid for another three days, but after that, my cards are maxed out, and I don't think you have a bank account.</q>
  ||
    --> I laugh. She looks so earnest, worrying about such a thing. And cute, too, with her breasts bobbing and cunt still dripping occasionally. I must be getting soft.

  || bg="Liana/Happy.jpg"
    -- We spend the next several hours going over a bit of local history and geography. "California" seems in just one kingdom in a larger empire, the Yousa. But we're in a small, isolated town which might as well just be begging for conversion into my new stronghold. A couple of foreign wars, but nothing local. Perfect.
  ||
    --> I don't like those things called "cars," though, that she assures me everyone has. The local constables might be able to summon the king's army within a few days. Then they'd burn all my tentacle gardens and lock me up and make me wear a bra in prison. That would be terrible.

  || bg="none"
    -- The first step, however, is clear enough. I need to establish a magical center, and to do that, I'll need some slaves. Liana's too valuable for that duty, and still needed to keep me from fading out of existence besides.
  ||
    --> Liana is a mage. I am a Dark Lady. We're staying in an inn (quite a large one, in fact). The task is trivial. I make one of the walls translucent to sight, then once we locate our targets, I rotate it out of existence entirely.

  || bg="Inn/Sleepover.jpg"
    -- She steps though, startling my new slaves. One of the women opens her mouth to scream, but Liana doesn't balk, as I half expected her to, and cuts the girl off with a spell. Both of my new slaves collapse into a deep slumber. They won't wake up until we have a use for them. She steps into another room, and I hear her repeat the same spell.
  ||
    --> She borrows one of their voices, and speaks to a machine on the bedside table, then informs me that the room is now ours to for the rest of the week.

  || bg="Liana/Happy.jpg"
    -- #{q @['Dark Lady']}Mine, silly girl. Not ours.</q>
  ||
    --> I do pat her on the head though. She can't decide if she should be happy or demeaned by the act. Both emotions are appropriate, I reassure her.
  ||
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
    '|officers|0': {}
  officers:
    'Dark Lady': '|officers|DarkLady'
    Liana: '|officers|Liana'
  type: 'plot'
  label: 'Conquest'
  text: ->"""I'm rather tired of the fact that my slaves have to put on clothes to move between rooms. Honestly, it's embarrassing how long it's taking me to conquer just one building."""

Job.IntroTakeOver::next = Page.IntroTakeOver = class IntroTakeOver extends Page
  conditions:
    DL: '|officers|DarkLady'
    Liana: {}
  text: ->"""|| bg="Liana/Happy.jpg"
    -- #{q @DL}Come, Liana, it's time to cease hiding in the shadows. Take me to the innkeeper so we can stop your ridiculous fretting about money.</q>
  ||
    --> #{q @Liana}Do you want to go to him, or shall I give him a call?</q>
  ||
    --> I blink. She's a smarty, this one is. Less chance of any witnesses if he comes to us. But no, I'm tired of being cooped up in this room. I do grumble a bit as I pull on clothes. Though Liana has nothing that fits properly, at least one of her "T shirts" can stretch to cover my more ample bosom.

  || bg="Inn/FrontDesk.jpg"
    -- "Hello! Welcome to Holiday Inn. Liana, right? I'm glad you decided to stay with us a few extra days. Is there anything I can help with?"
  ||
    --> #{q @DL}You can become my sex slave. I am taking over this establishment.</q>
  || bg="Inn/FrontDeskBlush.jpg"
    --> "Um..."
  ||
    --> I grin, and hit her with a wave of lust and obedience. Naturally, she blushes deeper and starts drooling over everyone in sight, lower lip trembling as she starts to strip.

  || bg="Inn/FrontDeskBra.jpg"
    -- The air in the room freezes. I glare at her. Everyone holds their breath as my face twists into a sneer. She's. Wearing. A. A...
  ||
    --> #{q @DL}Liana, what is that thing called again?</q>
  ||
    --> #{q @Liana}A bra, mistress.</q>

  ||
    --> #{q @DL}Right. A bra.</q>
  ||
    -- #{q}You, slave, she's not to be without a cock inside her for twenty four hours.</q> I order one of my male slaves to attend to her. #{q}After that you, bra-girl, return to the front desk. This place is closed for repairs until further notice, no more customers, but keep everything running like normal.</q>
  ||
    --> #{q}You can keep your shirt, since you'll be dealing with the outside world, but while you're behind that counter, no pants or underwear, ever.</q> Since I haven't actually mind controlled her, just added a hint of obedience and a pound of not-telling-anyone, I back my commands up with a threat. #{q}Anyone catches you with pants on inside this room, I'll make you work topless too.</q>

  ||
    -- Liana, perhaps sensing that I'm liable to keep ranting and raving and piling punishments on the hussy as long as that... thing... remains in my sight, banishes the bra with a spell.
  || bg="Inn/FrontDeskSex.jpg"
    --> I nod to the slave to begin her fucking. The Holiday Inn is mine. I can set up some <em>proper</em> facilities inside it now, and send slaves into the outer world.
  ||
    --> <em>New locations are now available</em>
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
