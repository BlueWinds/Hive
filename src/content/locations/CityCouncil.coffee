add class Council extends Place
  name: 'City Council'
  description: "Now that I've started to regain some serious magical power, it's time to extend my influence beyond the lowest strata of society."
  image: 'Council/Building'
  jobs: new Collection
    Fire: Job.Fire
  location: [264, 419]
  destinations: new Collection

add class Zoning extends Job
  place: 'Council'
  type: 'plot'
  conditions:
    '|events|Zoning': false
  people:
    'Dark Lady':
      is: Person.DarkLady
      matches: -> g.depravity >= 400
      label: -> if g.depravity >= 400 then 'Dark Lady' else 'Need <span class="depravity">400</span>'
    Liana:
      is: Person.Liana
      matches: -> g.depravity >= 400
  label: 'Zoning Laws'
  text: ->"""Liana says that if I take over land on the outskirts I'll get in trouble, even if I enslave the owners first.

  What kind of meddling government do these people have?

  <em class="depravity">-400</em>"""

add class Zoning extends Page
  text: ->"""|| bg="Council/Building"
    -- My poor brain. I've never seen a room filled with such boredom, seeping out of the walls and oozing into me like some boring-slime.

  || bg="Council/Vibrator"
    --> It's a good thing I brought a bunch of slaves to keep me entertained, trying not to squirm in the audience as their vibrators wiggle and thrust in and out. Combining a touch of magic with the Ooo-Essay's sex toys is a promising field of study.

    -- Liana draws on some of my power and slaps the old men with a bit of temporary suggestibility. `L Now, gentlemen, I know it's not on the agenda, but the north end of town is getting rather run down, isn't it? I'm sure you'll all be pleased to vote yes on my new ordinance for the promotion of industry. My mistress here will develop the area in accordance with...`

    --> Blah blah blah. I entertain myself for a few minutes while she takes care of business. Girl is smart. Old men have no resistance to magic. I have a new part of the city to expand into.

    -- <em>New location: <b>North End</b></em>
  """
  effects:
    depravity: -400
  apply: ->
    super()
    g.map.HolidayInn.destinations.NorthEnd = -1

add class Nudity extends Job
  place: 'Council'
  type: 'plot'
  people:
    'Dark Lady':
      is: Person.DarkLady
      matches: -> g.depravity >= 800
      label: -> if g.depravity >= 800 then 'Dark Lady' else 'Need <span class="depravity">800</span>'
    Liana:
      is: Person.Liana
      matches: -> g.depravity >= 800
  label: 'Public Nudity'
  text: ->"""Fuck skulking about and cloaking my servants in clothes or concealing magic. People should be free to show their bodies. Also, if public nudity is allowed, I can be more brazen in my activities.

  <em class="depravity">-800</em>, <span class="resistance">-1</span> daily"""

add class Nudity extends Page
  text: ->"""|| bg="Council/Building"
    -- My poor brain. I've never seen a room filled with such boredom, seeping out of the walls and oozing into me like some boring-oozing-slime-brain-hurty-thingie. I'm getting dumber just thinking about it.
    --> I'm being patient, though, hardly fidgeting at all while Liana deals with the formalities. `L Now, gentlemen, I'm here to speak in support of ordinance 12487...`
    --> Blah blah blah. They vote yes, of course - how could they not, when none of them are mages and the room's simply humming with her power, twisting everyone who isn't me around her cute little pinky. It is a very nice pinky. I spend several minutes admiring her. She starts squirming and glancing at me, until finally I decide that distracting her right now isn't the best option.

    -- ...I am going to die of boredom. This is it, this is how I end.

    -- `D Is it done?`
    --> `L Yes mistress.`
    -->  `D Very well. Naked, now, all of you.`
  || bg="Council/Nudity"
    -- I give the still slightly dazed old men of the city council a nice little reward as the audience - composed almost entirely of attractive slaves of mine - shed their clothes and reveal what's been going on underneath. They did just do me a favor, after all, and it might encourage them to continue to see things my way in the future.

    <em><span class="resistance">-1</span> daily. Can build Training Facilities in North End.</em>
  """
  effects:
    depravity: -800
    add:
      '|map|NorthEnd|jobs|7': Job.LargeRoom
    remove:
      '|map|Council|jobs|Nudity': Job.Nudity

Game.passDay.push ->
  if g.events.Nudity then g.applyEffects {resistance: -1}

add class BlackmailOfficer extends Job
  place: 'Council'
  type: 'plot'
  conditions:
    '|events|Zoning': {}
    '|events|Tentacles': {}
  people:
    Liana:
      is: Person.Liana
  label: 'Meddling Police'
  text: ->"""It seems someone has been poking around my operations. Since she's been itching to get out more, I'll send Liana to investigate."""

add class BlackmailOfficer2 extends Job
  place: 'Council'
  type: 'plot'
  people:
    'Dark Lady':
      is: Person.DarkLady
    Liana:
      is: Person.Liana
  label: 'Meddling Police'
  text: ->"""It seems someone has been poking around my operations. Since she's been itching to get out more, I'll send Liana to investigate."""

add class BlackmailOfficer extends Page
  text: ->"""|| bg="Council/Building"
    -- After several different slaves have reported being questioned by an attractive brunette police officer about magic and demons and similar areas, it's time to investigate. Liana is on the case. It's surprisingly simple - all she has to do is go down to the station and start poking around.
  || bg="Council/Police"
    -- ` You have information for me.`
    --> `L Not information, exactly.` The air begins to hum. Liana has grown more powerful at an almost frightening rate. She looks most alive when she's bending reality to her will. Also when her eyes are rolling back just before an orgasm. They're both pretty great expressions.
    --> This time, however, nothing much happens. The officer looks puzzled, touches a necklace she's wearing. It's just slightly warm, and Liana can tell her spell didn't take.

    -- `L Oh, um, I was just nervous about it. Sycamore Street has seemed less safe for a while now, and I have to walk along it every night on my way home, and I heard you talking about demons...`
    --> The officer gives her an odd look. The lie was not believed. ` I have to recommend you avoid the area for now. We're still searching for the perpetrators. But don't worry, we'll catch them soon.`
    --> Liana nods and thanks her for the advice. If the woman is resistant to our charms, we'll have to find another way to deal with her. It may take some time.
    --><em><span class="resistance">+2</span> daily until she's dealt with</em>
  """
  effects:
    remove:
      '|map|Council|jobs|BlackmailOfficer': Job.BlackmailOfficer
    add:
      '|map|Council|jobs|BlackmailOfficer2': Job.BlackmailOfficer2

Game.passDay.push ->
  if g.events.BlackmailOfficer and not g.events.BlackmailOfficer2 then g.applyEffects {resistance: 2}

add class BlackmailOfficer2 extends Page
  text: ->"""|| bg="Council/Police"
    -- ` You again. How can I help? There's still no word on Sycamore Street, if that's what you're after.` The officer is even more suspicious than last time.
    --> `L Oh, that's ok. I actually came back to ask you to drop the investigation.`
    --> ` Why would we do that? Also, I would like to ask you a few questions. Please step into the back with me.`
    --> `D That won't be necessary. It's a nice locket you have there - very old, very powerful. I can see you didn't make it yourself.` I step around the corner.

    -- ` And who are you?` The officer is instantly on guard - we caught her just before going home in the evening. There are a few others sitting at their desks nearby, but they won't bother us, sitting completely frozen and vacant-eyed under my sway. She self-consciously touches her necklace - she doesn't really know what's going on. A dabbler who got lucky and found an item of real power, then.

    --> I snap my fingers, and a little scrying window appears. She jumps, reflexively putting a hand on her scabbard. I wouldn't normally worry too much, she can't have more than a dagger in there, but apparently the police in this day and age carry miniature crossbows or something? Liana made them sound pretty dangerous. That's still ok. She couldn't kill me.

    -- Wait, no, not ok. Liana's here, and if she dies, I disappear again. I should have come alone. Also, I should teach her how to protect herself better. The policewoman doesn't draw her weapon though, and leans cautiously closer to look into my scrying pool.

  || bg="Council/MaleTentacles"
    --> ` Donny... what is...`
    --> `D Your husband, correct? He's enjoying himself. But he'd stop enjoying himself pretty quick without my powers. The magic in the slime is addictive.`
    --> It only takes her a moment to process what she's seeing. A formidable woman. I hope she loves her husband as much as he loves her.

  || bg="Council/Police"
    -- ` Addictive tentacle slime.` Her voice is flat, and scary in its own way, but not disbelieving. Good.
    --> `D You'd have to physically restrain him up to stop him from visiting me. And if he doesn't show up once a week from now on, news just might leak that you're keeping your husband chained up in your basement.`
    --> ` What do you want.`

    -- `D Oh, just don't voice your concerns about the supernatural any more. I won't ask you not to do your job, that'd be silly, we want everyone kept safe as much as you. But no more questions about demons. Magic's real, and we're better at it than you.`
    --> ` Fuck you. But as long as Donny's ok, I'll play ball.`
  || bg="Liana/Happy"
    --> Liana grins happily. `L Oh, he's fine. It's pretty fun, honestly, you should give it a try. Your necklace would keep you safe, don't worry. First visit's always free.`
    --> <em>End of <span class="resistance">+2</span> daily from investigating officer</em>
  """
  effects:
    remove:
      '|map|Council|jobs|BlackmailOfficer2': Job.BlackmailOfficer2

Place.Council::jobs.Dorm = add class DormApproval extends Job
  type: 'plot'
  people:
    Liana:
      is: Person.Liana
      label: -> if g.depravity >= 400 then 'Liana' else 'Need <span class="depravity">400</span>'
      matches: -> g.depravity >= 400
  conditions:
    '|events|BlackmailOfficer2|0': matches: (d)-> d < (g.day - 5)
  label: 'College Dormitory'
  text: ->"""<q class="L">The city is accepting bids for a new dormitory. We're not state certified contractors, but one of you pets is.</q>
  <q class="D">Huh?</q>
  <q class="L">I can make people be naked even when they don't want to be.</q>
  <q class="D">Ah. By all means.</q>

  <em class="depravity">-400</em>"""

add class ConstructDorm extends Job
  type: 'plot'
  people:
    DarkLady:
      is: Person.DarkLady
      label: ->
        if g.depravity >= 200 and g.men >= 4 and g.women >= 4
          'Dark Lady'
        else
          'Need <span class="depravity">200</span>, <span class="women">4</span> and <span class="men">4</span>'
      matches: -> g.depravity >= 200 and g.men >= 4 and g.women >= 4
    Liana:
      is: Person.Liana
      matches: -> g.depravity >= 200 and g.men >= 4 and g.women >= 4
  label: 'Construct Dorm'
  text: ->"""The biggest building I've yet constructed. I'm not really sure where Liana's going with this, but seems like she has some ideas, so...

  <em class="depravity">-200</em>, <span class="women">-4</span> and <span class="men">-4</span>, <span class="resistance">+1</span> daily"""

add class DormApproval extends Page
  text: ->"""|| bg="Inn/FrontDeskPanties"
    -- ` As you can see in the proposal, I've managed the Holiday Inn here for five years, and during that time, patronage has grown immensely. With my experience in hospitality and guest management... aaah, um, I'm uniquely qualified to... ahh...`
    --> ` Is everything allright, maam?`
    -->  ` Yes, I'm sorry. As sorry. Um. As I was saying...`

  || bg="Inn/FrontDeskSquirm"
    -- `D Liana. Stop playing with the vibrator and let the woman speak,` I whisper to her, and take the remote out of her hand. `D It'll be easier to focus if it doesn't keep changing settings on her.` I set it to maximum.
    --> ` Ah, yes, very sorry. Mmm. So as you can see in the documents provided, aahh, due to contacts in the construction industry...`
    --> The police woman we're blackmailing glares at us, but doesn't say anything. I'm sure she'll keep a close eye on our new project, but that's ok - she won't find anything untoward. Just lots of exposed flesh.
  """
  effects:
    remove:
      '|map|Council|jobs|Dorm': Job.DormApproval
    add:
      '|map|Council|jobs|Dorm': Job.ConstructDorm

dormDepravity = ->
  d = 15
  if g.events.DormHourly then d += 10
  if g.events.DormDiscount then d += 10
  return d

add class Dorm extends Job
  label: "College Dorm"
  text: ->"""Men pay double rent. Women are free, but have to rent thoir clothing by the square foot by the hour. <span class="depravity">+#{dormDepravity()}</span> daily"""
  people: {}
  type: 'boring'

add class ConstructDorm extends Page
  text: ->"""|| bg="Dorm/Empty"
    -- `D Hm. Seems kind of boring so far. And people just live here?`
    --> `L It's all in how you sell it. I'm setting the price at about double the other dorms for men, but women get to live here free. The kick is that they're not allowed to own clothes while they live here. Anything wearable has to be rented from the front desk by the hour.`
    --> `D I like it.`

    -- `L It's all upfront in the rental agreement, they know what they're in for. Well, mostly. I'll be slowly raising the price for more conservative clothes and reducing it for sluttier ones. Um... I have to make bras available to start, but I'll be raising the price very... Aah!`

  || bg="Liana/Nude"
    --> `L My clothes! I'm sorry mistr... mghmph!`
  || bg="Liana/Bound"
    --> `D No bras.`
  """
  effects:
    remove:
      '|map|Council|jobs|Dorm': Job.ConstructDorm
    add:
      '|map|Council|jobs|Dorm': Job.Dorm

Job.Dorm::next = add class DormDaily extends Page
  conditions:
    depravity: fill: dormDepravity
  text: ->
    if $('page').length and Math.random() < 0.75 then return false
    c = [
      """|| bg="Dorm/11"
        -- ` I keep thinking about that new dorm that opened. I hear from the women who live there what a good deal it is - I could quit my part time job and spend those hours studying.`
      || bg="Dorm/12"
        --> ` But have you seen the way they dress? I'm really not sure if it's worth it - my parents would be so upset if they found out. And my boyfriend...`
      || bg="Dorm/13"
        --> `Well, I'm pretty sure he'd like it at least.`"""
      """|| bg="Dorm/21"
        -- The old chearleading uniforms were cute, but with so many of the women living in my dorms, they've had to cut back a bit.
      || bg="Dorm/22"
        --> It's still a bit expensive - discussions in the locker room is usually about who they'll have to blow to get a few more inches taken off the top, and tank top."""
      """|| bg="Dorm/31"
        -- ` ...if I go to sleep naked, I'll have to walk to the front desk to get something to wear in the morning...`
      || bg="Dorm/32"
        --> ` Oh hell, fine. I guess it's not any more embarrassing than the other things I've done since I moved in here.`"""
      """|| bg="Dorm/41"
        -- ` You fucking pervs, staring at me all the time. I catch you looking my way one more time...`
      || bg="Dorm/42"
      || bg="Dorm/43"
        -- ` I hate this goddamn wind. That's it, I'm moving back to a sane dormitory as soon as my contract's up.`"""
      """|| bg="Dorm/5"
        -- Dorm rules apply even on weekends and holidays - riding the train into the city is expensive or exhibitionary, pick one."""
      """|| bg="Dorm/6"
        -- Two layers up top so her nipples didn't show, or panties. One has to make tough choices in this economy."""
      """|| bg="Dorm/7"
        -- She thought she was safe wearing long pants. Whoops."""
      """|| bg="Dorm/8"
        -- Borrowing clothes from a friend is a breach of contract. The monitors always know, somehow. Someone will come by and let her out in a few hours."""
    ]

    if g.events.DormHourly
      c.push """|| bg="Dorm/Hourly1"
        -- Hiding naked in the bathroom between classes.
        --> Aww, poor dear. The budget this month must be rough."""
      c.push """|| bg="Dorm/Hourly2"
        -- If you're going to hide in the bathrooms naked between classes, make absolutely certain you lock the stall door."""
      c.push """|| bg="Dorm/Hourly3"
        --` I, uh, I wasn't doing anything! Wait, no, you can't come in, you pervy janitor!`"""
      c.push """|| bg="Dorm/Hourly41"
        -- Out for a weekend ride, she waits until she's out where no one's around...
      || bg="Dorm/Hourly42"
        -- ...and the clothes come off. What she was wearing before was pretty cheap - maybe she was just looking for an excuse."""

    if g.events.DormDiscount
      c.push """|| bg="Dorm/Discount1"
        -- She didn't think it would be this hard to focus on the lecture with the <em>non</em>-vibrating version. Unfortunately, I was feeling a bit vindictive this morning and enchanted all the dildos to squirm."""
      c.push """|| bg="Dorm/Discount2"
        -- The vibrator will turn on at some point today, and won't turn off. If she wears it all day, her clothes are free - if she takes it out, they cost double. Better hope it waits until she's home for the evening..."""
      c.push """|| bg="Dorm/Discount3"
        -- Some of the discount tasks are more aggressive than others. They'll be getting free clothing for a week - combined with free rent, it makes college much more affordable."""
      c.push """|| bg="Dorm/Discount4"
        -- Staying in her own locker all day in return for a week's free clothing - how unlucky that the buzzing attracted attention!"""
      c.push """|| bg="Dorm/Discount5"
        -- Was the chastity-belt, orgasm denying magic and vibrator combo really worth it, girl? I mean, yes, you're actually making money right now rather than spending it, but that stuff isn't coming off for a week."""

    """|| class="jobStart" auto="1800"
        <h4>College Dorm</h4>

      #{Math.choice c}
      <em><span class="depravity">+#{dormDepravity()}</span>, <span class="resistance">+1</span></em>
    """
  effects:
    depravity: 'depravity'
    resistance: 1

add class DormHourly extends ResearchJob
  label: "True Hourly Rates"
  progress: 300
  conditions:
    '|events|DormDaily': {}
  text: ->"""<span class="depravity">+10</span> per day from the Dorm.
    <br>If we charge by the hour <i>worn</i> rather than by the hour <i>rented</i>, we can draw women into all sorts of compromising situations."""

add class DormHourly extends Page
  text: ->"""|| bg="Dorm/Hourly3"
    -- "Dead batteries," groaned frustrated Corrie,
      As she urgently took inventory,
      Of her vegetable crisper,
      And moaned in a whisper,
      "I am so hot from reading that story."
  """

add class DormDiscount extends ResearchJob
  label: "Dorm Discounts"
  progress: 300
  conditions:
    '|events|DormDaily': {}
    '|events|Nudity': {}
  text: ->"""<span class="depravity">+10</span> per day from the Dorm.
    <br>Idea. We can offer discounts on various clothing items if the girls perform various... tasks. It's not prostitution if <em>they're</em> paying <em>us!</em>"""

add class DormDiscount extends Page
  text: ->"""|| bg="Dorm/Discount1"
    -- "There was a young lass from Port Keel
      Whose genitals were made of blue steel.
      She got all her thrills,
      From pneumatic drills,
      And an off-centered emery wheel."
  """
