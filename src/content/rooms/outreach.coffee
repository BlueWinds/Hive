Place.Rooms::jobs.outreach = RoomJob.Outreach = class Outreach extends RoomJob
  label: "Community Outreach Center"
  size: 'medium'
  effects:
    depravity: -150
    men: 2
    women: 2
  text: ->"""I can't just take over this village with a horde of orcs, like I would have in the old days. The authorities are too well organized. I'll need a comunity outreach center to start <span class="strike">brainwashing</span> educating the populace into joining me willingly."""

RoomJob.Outreach::next = Page.Outreach = class Outreach extends Page
  text: -> """|| bg="Outreach/1.jpg"
    -- Humans like being slaves, and they like owning slaves, and they like sex. With some... volunteers... I can help remind them of these facts, which in turn makes them much less likely to call upon the kingdom to defend them from my efforts.
    -- More importantly, though, I can get volunteers!
    -- I love volunteers.
  """

RoomJob.Outreach::room = Job.Outreach = class Outreach extends Job
  label: "Outreach Center"
  text: -> """Snatching women of the street is effective, but I can't do it too often or people will stop going out alone. A nice "Hiring" sign though and some cute bimbos, though? Attracts young people like flies to honey.
  <br><em>Recruit slaves safely</em>"""
  officers:
    worker:
      gender: is: 'f'
    worker2:
      gender: is: 'f'
    worker3:
      gender: is: 'f'
      optional: true
  stat: 'lust'
  difficulty: 30
  next: Page.statCheck
  @next: {}
  type: 'boring'

Page.OutreachMan = class OutreachMan extends Page
  text: ->
    if Math.random() < 0.75  or g.events.Outreach?[0] is g.day then return false
    """|| bg="Outreach/3.jpg"
      -- Bikini babes handing out flyiers for a free welcome barbecue? Sign one new (soon to be) slave up. He hardly even objected when the girls told him it was a lifetime commitment (the breasts almost popping out of her string bikini probably had something to do with that).
      <em class="men">+1</em>
    """
  effects:
    men: 1

Page.OutreachWoman = class OutreachWoman extends Page
  text: ->
    if Math.random() < 0.75  or g.events.Outreach?[0] is g.day then return false
    """|| bg="Outreach/2.jpg"
      -- "Will I really be able to look like that?"
        "Of course!" My slave grinned and shook her ass. "One of the perks of such an active lifestyle. And the guys produce a special cream which is wonderful for the complexion..."
      <em class="women">+1</em>
    """
  effects:
    women: 1

Page.OutreachVirgin = class OutreachVirgin extends Page
  text: ->
    if Math.random() < 0.75  or g.events.Outreach?[0] is g.day then return false
    """|| bg="Outreach/1.jpg"
      -- "Oh, aren't you the cutest little thing. Just out of high-school, are you, and looking for a job? Excellent, well, I have an opportunity I think would fit great inside yo... oops, I mean would be a great for <em>for</em> you..."
      <em class="virgins">+1</em>
    """
  effects:
    virgins: 1

Page.OutreachMen = class OutreachMen extends Page
  text: ->
    if Math.random() < 0.75  or g.events.Outreach?[0] is g.day then return false
    """|| bg="Outreach/Men.jpg"
      -- "I'll let you fuck me," she slips one breast out of her blouse, playing with the nipple.
      Silence.
      "And a six pack of beer."
      They grin and sign.
      <em class="men">+3</em>
    """
  effects:
    men: 3

Page.OutreachWomen = class OutreachWomen extends Page
  text: ->
    if Math.random() < 0.75  or g.events.Outreach?[0] is g.day then return false
    """|| bg="Outreach/Women.jpg"
      -- <em class="women">+3</em>
    """
  effects:
    women: 3

Page.OutreachMixed = class OutreachMixed extends Page
  text: ->
    if Math.random() < 0.75  or g.events.Outreach?[0] is g.day then return false
    """|| bg="Outreach/Women2.jpg"
      -- "Come on, it looks fun."
      "I dunno, m-maybe we should think more about the 'sex slave' part..."
      "Stop being a pussy. The money's good, and I know you're a pervert. And you always end up giving in, so let's just skip the whining and have a good time."
      "B-but..."
      <em class="women">+2</em>, <em class="virgins">+1</em>
    """
  effects:
    women: 2
    virgins: 1

Page.Outreach.next['bad'] = Page.OutreachBad = class OutreachBad extends Page
  text: ->
    if Math.random() < 0.75  or g.events.Outreach?[0] is g.day then return false
    """|| bg="Outreach/Resting.jpg"
      -- The girls ran around looking for someone to recruit, but didn't manage to attract any attention."""

Page.Outreach.next['good'] = Page.OutreachGood = class OutreachGood extends Page
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.OutreachMan,
    Page.OutreachMan,
    Page.OutreachWoman,
    Page.OutreachWoman,
    Page.OutreachVirgin
  ]

Page.Outreach.next['veryGood'] = Page.OutreachVeryGood = class OutreachVeryGood extends Page
  text: ->false
  next: Page.trueRandom
  @next: [
    Page.OutreachMen,
    Page.OutreachWomen,
    Page.OutreachMixed
  ]
