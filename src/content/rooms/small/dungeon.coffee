add class Dungeon extends RoomJob
  label: "Dungeon"
  effects:
    depravity: -25
    men: -2
  size: 'small'
  text: ->"""Slaves need a place to stay too, until I find a task for them. I can't have more than six unused slaves per dungeon. Takes two male slave-guards to keep them fed and clean and pacified."""

add class Dungeon extends Page
  text: -> """|| bg="Dungeon/Empty"
    -- Normally I'd have a team of architects to handle this sort of mundane work, but with things as they are, well...
    --> One thing this pathetic kingdom of "America" does do well is buildings. It's hardly even cold at all, much more pleasant for the inmates. I'm more of a torture-you-with-pleasure sort of Dark Lady than a torture-you-with-misery one, so that's nice.
    --> All I need is some additional soundproofing and a couple of places to set the chains in the floor, and my new dungeon is complete.
  """

dungeonCum = -> Math.min(g.men, Math.ceil(g.men / g.space) * 6)

add class Dungeon extends Job
  label: "Dungeon"
  text: ->"""It's a dungeon. It holds six slaves until I find a use for them. #{if g.events.DungeonCum then "\n\n<em><span class=\"cum\">+" + dungeonCum() + "</span></em>" else "No fun to be had here, just a soundproofed holding pen."}"""
  type: 'boring'
  people:
    Gaoler:
      hide: -> not g.events.DungeonCum?
      optional: true

Job.Dungeon::next = add class DungeonDaily extends Page
  conditions:
    Gaoler: {}
    cum: fill: -> if g.events.DungeonCum and @Gaoler then dungeonCum() else 0
  text: ->
    if $('page').length and (Math.random() < 0.75 or g.events.DungeonDaily?[0] is g.day) then return false

    c = [
      """|| bg="Dungeon/Empty"
        -- It's not my favorite place to keep people, but sometimes they just need to wait their turn for a while."""
      """|| bg="Dungeon/1"
        -- She looks so excited, doesn't she? But she'll just have to wait a few days while I decide whether she's going to be the one fucking or the getting fucked.""",
      """|| bg="Dungeon/2"
        -- The screaming got to be a bit much. I decorated her with a bit of extra chain while I was at it.""",
      """|| bg="Dungeon/3"
        -- I love that rebellious expression. She'll make the cutest little dominatrix, won't she?""",
    ]
    if g.events.DungeonCum and @Gaoler
      c = [
        """|| bg="Dungeon/Cum1"
          -- We gave the men waiting for assignment one of our female prisoners, and told them to do... whatever. I guess they were pretty bored."""
        """|| bg="Dungeon/Cum2"
          -- You know, the gaoler probably shouldn't be putting herself in such a vulnerable position. But they are pretty hot, so I guess I can't blame her too much."""
        """|| bg="Dungeon/Cum3"
          -- Not all the male prisoners <em>want</em> to be tied up and milked for their cum. Tough."""
        """|| bg="Dungeon/Cum4"
          -- Using one prisoner to satisfy another. Classy."""
      ]

    if g.women and g.events.DungeonPregnancy
      c.push """|| bg="Dungeon/Preg1"
        -- They aren't <em>willing</em>, just fertile and at my mercy. I'll make their births easy and pleasurable though - that only takes a touch of magic, and I do want them healthy afterwards."""
      c.push """|| bg="Dungeon/Preg2"
        -- Tied up for daily inspection. The jailer is very... thorough, especially with those near birth."""
      c.push """|| bg="Dungeon/Preg3"
        -- Being pregnant is no reason for the fathers to stop fucking them. The fathers and their friends, that is. Or the fathers and their friends and some random strangers, and the male prisoners, and..."""
      c.push """|| bg="Dungeon/Preg4"
        -- I like to set aside a few hours each day to torment my prisoners, especially the pregnant ones. The orgasms are good for their babies, and stronger abdominal muscles will aid with  the birth."""


    return """|| class="jobStart" auto="1800"
        <h4>Dungeon</h4>

    """ + Math.choice c
  effects:
    cum: 'cum'

add class DungeonCum extends ResearchJob
  conditions:
    '|events|MoreResources': {}
  label: "Dungeon Collection"
  progress: 150
  text: ->"""Up to <span class="cum">+6</span> when working a dungeon (if the cells are full of <span class="men"></span>).
    <br>There's no reason those waiting assignments in the dungeon shouldn't contribute to their new society."""

add class DungeonCum extends Page
  text: ->"""|| bg="Dungeon/Cum4"
    -- A certain young fellow from Ransome
      Had a dame seven times in a hansom.
      When she shouted for more,
      he said from the floor,
      The name, miss, is Simpson not Samson.
  """

add class DungeonPregnancy extends ResearchJob
  conditions:
    '|events|Resistance': {}
  label: "Public Use"
  progress: 300
  text: ->"""Rent-a-womb - by selling my sluts' as wombs to the locals, I can bring in rich visitors... who will need to help protect my secrecy long-term if they want their new slave-wife to come to term.

  <span class="resistance">-0.25</span> daily as long as there are <span class="women"></span> prisoners"""

add class DungeonPregnancy extends Page
  text: ->"""|| bg="Dungeon/Preg2"
    -- Q. What is the most common pregnancy craving?
       A. For men to be the ones who get pregnant.

       Q. What’s the difference between a pregnant woman and a lightbulb?
       A. You can unscrew a lightbulb.
  """
