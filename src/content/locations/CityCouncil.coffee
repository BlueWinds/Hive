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
  text: ->"""Fuck skulking about and cloaking my servants in clothes or concealing magic. People should be free to show their bodies.

  <em class="depravity">-800</em>"""

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
  """
  effects:
    depravity: -800
    remove:
      '|map|Council|jobs|Nudity': Job.Nudity

add class BlackmailOfficer extends Job
  place: 'Council'
  type: 'plot'
  conditions:
    '|events|Zoning': {}
    '|events|CatchPolice': {}
  people:
    Liana:
      is: Person.Liana
  label: 'Meddling Police'
  text: ->"""It seems someone has been poking around my operations. Since she's been itching to get out more, I'll send Liana to investigate."""

add class BlackmailOfficer2 extends Job
  place: 'Council'
  type: 'plot'
  conditions:
    '|events|BlackmailOfficer|0': matches: (d)-> d < (g.day - 10)
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
    -- ` Do you have information for me.`
    --> `L Not information, exactly.` The air begins to hum. Liana has grown more powerful at an almost frightening rate. She looks most alive when she's bending reality to her will. Also when her eyes are rolling back just before an orgasm. They're both pretty great expressions.
    --> This time, however, nothing much happens. The officer looks puzzled, touches a necklace she's wearing. It's just slightly warm, and Liana can tell her spell didn't take.

    -- `L Oh, um, I was just nervous about it. Sycamore Street has seemed less safe for a while now, and I have to walk along it every night on my way home, and I heard you talking about demons...`
    --> The officer gives her an odd look. The lie was not believed. ` I have to recommend you avoid the area for now. We're still searching for the perpetrators. But don't worry, we'll catch them soon.`
    --> Liana nods and thanks her for the advice. If the woman is resistant to our "charms", we'll have to find another way to deal with her. It may take some time.
  """
  effects:
    remove:
      '|map|Council|jobs|BlackmailOfficer': Job.BlackmailOfficer
    add:
      '|map|Council|jobs|BlackmailOfficer2': Job.BlackmailOfficer2

add class BlackmailOfficer2 extends Page
  text: ->"""|| bg="Council/Police"
    -- ` You again. How can I help? There's still no word on Sycamore Street, if that's what you're after.` The officer is even more suspicious than last time.
    --> `L Oh, that's ok. I actually came back to ask you to drop the investigation.`
    --> ` Why would we do that? Also, I would like to ask you a few questions. Please step into the back with me.`
    --> `D That won't be necessary. It's a nice locket you have there - very old, very powerful. I can see you didn't make it yourself.` I step around the corner.

    -- ` And who are you?` The officer is instantly on guard - we caught her just before going home in the evening. There are a few other officers sitting at their desks, but they won't bother us, I've made sure of that. She self-consciously touches her necklace - she doesn't really know what's going on. A dabbler woh got lucky and found an item of real power, then.

    --> I snap my fingers, and a little scrying window appears. She jumps, reflexively putting a hand on her scabbard. I wouldn't normally worry too much, she can't have more than a dagger in there, but apparently the police in this day and age carry miniature crossbows or something? Liana made them sound pretty dangerous. That's still ok. She couldn't kill me.

    -- Wait, no, not ok. Liana's here, and if she dies, I disappear again. I should have come alone. Also, I should teach her how to protect herself better. She doesn't draw her weapon though, and leans cautiously closer to look into my scrying pool.

  || bg="Council/MaleTentacles"
    --> ` Donny... what is...`
    --> `D Your husband, correct? He's enjoying himself. But he'd stop enjoying himself pretty quick without my powers. The magic in the slime is addictive.`
    --> It only takes the policewoman a moment to process what she's seeing. A formidable woman. I hope she loves her husband as much as he loves her.

  || bg="Council/Police"
    -- ` Addictive tentacle slime.` Her voice is flat, and scary in its own way, but not disbelieving. Good.
    --> `D You'd have to physically restrain him up to stop him from visiting me. And if he doesn't show up once a week from now on, news just might leak that you're keeping your husband chained up in your basement.`
    --> ` What do you want.`

    -- `D Oh, just don't voice your concerns about the supernatural any more. I won't ask you not to do your job, that'd be silly, we want everyone kept safe as much as you. But no more questions about demons. Magic's real, and we're better at it than you.`
    --> ` Fuck you. But as long as Donny's ok, I'll play ball.`
  || bg="Liana/Happy"
    --> Liana grins happily. `L Oh, he's fine. It's pretty fun, honestly, you should give it a try. Your necklace would keep you safe, don't worry. First visit's always free.`
  """
  effects:
    remove:
      '|map|Council|jobs|BlackmailOfficer2': Job.BlackmailOfficer2
