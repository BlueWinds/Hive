add class Outreach extends RoomJob
  label: "Community Outreach Center"
  size: 'medium'
  effects:
    depravity: -150
    men: -2
    women: -2
  text: ->"""I can't just take over this village with a horde of orcs, like I would have in the old days. The authorities are too well organized. I'll need a community outreach center to start <span class="strike">brainwashing</span> educating the populace into joining me willingly."""

add class Outreach extends Page
  text: -> """|| bg="Outreach/1"
    -- Humans like being slaves, and they like owning slaves, and they like sex. With some... volunteers... I can help remind them of these facts, which in turn makes them much less likely to call upon the kingdom to defend them from my efforts.
    -- More importantly, though, I can get volunteers!
    -- I love volunteers.
  """

add class Outreach extends Job
  label: "Outreach Center"
  text: -> """Snatching women of the street is effective, but I can't do it too often or people will stop going out alone. A nice "Hiring" sign and some cute bimbos, though? Attracts young people like flies to honey.
  <br><em>Recruit slaves safely.</em>

  #{Page.statCheckDescription('lust', 30, Job.Outreach.next, @context)}"""
  people:
    worker: {}
    worker2:
      optional: true
    worker3:
      optional: true
  stat: 'lust'
  difficulty: 40
  next: Page.statCheck
  @next: {}
  type: 'boring'

add class OutreachMan extends Page
  text: ->
    if $('page').length and (Math.random() < 0.5 or g.events.Outreach?[1] is g.day) then return false
    """|| class="jobStart" auto="1800"
      <h4>Outreach Center</h4>
    || bg="Outreach/3"
      -- Bikini babes handing out fliers for a free welcome barbecue? Sign one new (soon to be) slave up. He hardly even objected when the girls told him it was a lifetime commitment (the breasts almost popping out of her string bikini probably had something to do with that).
      <em class="men">+1</em>
    """
  effects:
    men: 1

add class OutreachWoman extends Page
  text: ->
    if g.events.Outreach?[1] is g.day then return false
    """|| class="jobStart" auto="1800"
      <h4>Outreach Center</h4>
    || bg="Outreach/2"
      -- "Will I really be able to look like that?"
        "Of course!" My slave grinned and shook her ass. "One of the perks of such an active lifestyle. And the guys produce a special cream which is wonderful for the complexion..."
      <em class="women">+1</em>
    """
  effects:
    women: 1

add class OutreachVirgin extends Page
  text: ->
    if g.events.Outreach?[1] is g.day then return false
    """|| class="jobStart" auto="1800"
      <h4>Outreach Center</h4>
    || bg="Outreach/1"
      -- "Oh, aren't you the cutest little thing. Just out of high-school, are you, and looking for a job? Excellent, well, I have an opportunity I think would fit great inside yo... oops, I mean would be a great fit <em>for</em> you..."
      <em class="virgins">+1</em>
    """
  effects:
    virgins: 1

add class OutreachMen extends Page
  text: ->
    if g.events.Outreach?[1] is g.day then return false
    """|| class="jobStart" auto="1800"
      <h4>Outreach Center</h4>
    || bg="Outreach/Men"
      -- "I'll let you fuck me," she slips one breast out of her blouse, playing with the nipple.
      Silence.
      "And a six pack of beer."
      They grin and sign.
      <em class="men">+3</em>
    """
  effects:
    men: 3

add class OutreachWomen extends Page
  text: ->
    if g.events.Outreach?[1] is g.day then return false
    """|| class="jobStart" auto="1800"
      <h4>Outreach Center</h4>
    || bg="Outreach/Women"
      -- <em class="women">+3</em>
    """
  effects:
    women: 3

add class OutreachMixed extends Page
  text: ->
    if g.events.Outreach?[1] is g.day then return false
    """|| class="jobStart" auto="1800"
      <h4>Outreach Center</h4>
    || bg="Outreach/Women2"
      -- "Come on, it looks fun."
      "I dunno, m-maybe we should think more about the 'sex slave' part..."
      "Stop being a pussy. The money's good, and I know you're a pervert. And you always end up giving in, so let's just skip the whining and have a good time."
      "B-but..."
      <em class="women">+2</em>, <em class="virgins">+1</em>
    """
  effects:
    women: 2
    virgins: 1

Job.Outreach.next['bad'] = add class OutreachBad extends Page
  text: ->
    if g.events.Outreach?[0] is g.day then return false
    """|| class="jobStart" auto="1800"
      <h4>Outreach Center</h4>
    || bg="Outreach/Resting"
      -- The girls ran around looking for someone to recruit, but didn't manage to attract any attention."""

Job.Outreach.next['good'] = add class OutreachGood extends Page
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.OutreachMan,
    Page.OutreachMan,
    Page.OutreachWoman,
    Page.OutreachWoman,
    Page.OutreachVirgin
  ]

Job.Outreach.next['veryGood'] = add class OutreachVeryGood extends Page
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.OutreachMen,
    Page.OutreachWomen,
    Page.OutreachMixed
  ]
