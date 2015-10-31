add class Council extends Place
  name: 'City Council'
  description: "Now that I've started to regain some serious magical power, it's time to extend my influence beyond the lowest strata of society."
  image: 'Council/Building.jpg'
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
    DarkLady:
      is: Person.DarkLady
      matches: -> g.depravity >= 400
      label: -> if g.depravity >= 400 then 'Dark Lady' else 'Need <span class="depravity">400</span>'
    'Liana':
      is: Person.Liana
      matches: -> g.depravity >= 400
  label: 'Zoning Laws'
  text: ->"""Liana says that if I take over land on the outskirts I'll get in trouble, even if I enslave the owners first.

  What kind of meddling government do these people have?

  <em class="depravity">-400</em>"""

add class Zoning extends Page
  text: ->"""|| bg="Council/Building.jpg"
    -- My poor brain. I've never seen a room filled with such boredom, seeping out of the walls and oozing into me like some boring-slime.

  || bg="Council/Vibrator.jpg"
    --> It's a good thing I brought a bunch of slaves to keep me entertained, trying not to squirm in the audience as their vibrators wiggle and thrust in and out. Combining a touch of magic with the Yousa's sex toys is a promising field of study.

    -- Liana draws on some of my power and slaps the old men with a bit of temporary suggestibility. `L Now, gentlemen, I know it's not on the agenda, but the north end of town is getting rather run down, isn't it? I'm sure you'll all be pleased to vote yes on my new ordinance for the promotion of industry. My mistress here has will develop the area in accordance with...`

    --> Blah blah blah. I entertain myself for a few minutes while she takes care of business. Girl is smart. Old men have no resistance to magic. I have a new part of the city to expand into.

    -- <em>New location: <b>North End</b></em>
  """
  effects:
    depravity: -400
  apply: ->
    super()
    g.map.HolidayInn.destinations.NorthEnd = -1

# add class Nudity extends Job
#   place: 'Council'
#   type: 'plot'
#   conditions:
#     '|events|Nudity': false
#   people:
#     DarkLady:
#       is: Person.DarkLady
#       matches: -> g.depravity >= 800
#       label: -> if g.depravity >= 800 then 'Dark Lady' else 'Need <span class="depravity">800</span>'
#     'Liana':
#       is: Person.Liana
#       matches: -> g.depravity >= 800
#   label: 'Public Nudity'
#   text: ->"""Fuck skulking about and cloaking my servants in clothes or concealing magic. People should be free to show their bodies.
#
#   <em class="depravity">-800</em>"""
#
# add class Nudity extends Page
#   text: ->"""|| bg="Council/Building.jpg"
#     -- My poor brain. I've never seen a room filled with such boredom, seeping out of the walls and oozing into me like some boring-oozing-slime-brain-hurty-thingie. I'm getting dumber just thinking about it.
#     --> I'm being patient, though, hardly fidgeting at all while Liana deals with the formalities. `l Now, gentlemen, I'm here to speak in support of ordinance 12487...`
#     --> Blah blah blah. They vote yes, of course - how could they not, when none of the are mages and the room's simply humming with power, twisting everyone who isn't me around her cute little pinky.
#
#     -- `D Is it done?`
#     --> `L Yes mistress.`
#     -->  `D Very well. Naked, now, all of you.`
#   || bg="Council/Nudity.jpg"
#     -- I give the still slightly dazed old men of the city council a nice little reward as the audience - composed almost entirely of attractive slaves of mine - shed their clothes and reveal what's been going on underneath. They did just do me a favor, after all, and it might encourage them to continue to see things my way in the future.
#   """
#   effects:
#     depravity: -800
