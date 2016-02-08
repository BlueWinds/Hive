slutroomDepravity = ->
  e = 4
  if g.events.SlutroomOral then e += 1
  if g.events.SlutroomFisting then e += 1
  if g.events.SlutroomStrapon then e += 1
  if g.events.SlutroomSybian then e += 1
  return e

add class Slutroom extends RoomJob
  label: "Slutroom"
  effects:
    depravity: -20
    women: -2
  size: 'small'
  text: ->"""Mind wiping a pair of girls and installing them with permanent orders to pleasure each other. <span class="depravity">+#{slutroomDepravity()}</span> daily."""

add class Slutroom extends Page
  text: -> """||
    -- A slutroom is really quite simple. It needs three things.
  || bg="Slutroom/Bed"
    --> A bed.
  || bg="Slutroom/Food"
    --> An enchanted plate of self-renewing food.
  || bg="Slutroom/1"
    --> And a pair of mindless women with orders to fuck for all eternity.
  """

add class Slutroom extends Job
  label: "Slutroom"
  text: ->"""Simply letting the two mindless fuckslaves go at it 18 hours a day is the purpose of a slutroom. <span class="depravity">+#{slutroomDepravity()}</span> daily"""
  people: {}
  type: 'boring'

Job.Slutroom::next = add class SlutroomDaily extends Page
  conditions:
    depravity: fill: slutroomDepravity
    cum: fill: -> if g.events.SlutroomCum then 1 else 0
  text: ->
    if $('page').length and (Math.random() < 0.75 or g.events.SlutroomDaily?[0] is g.day) then return false
    c = [
      """|| bg="Slutroom/1"
        -- I poke my head in for a moment, but all is as it should be, horny and wet and mindless.""",
      """|| bg="Slutroom/2"
        -- The chains are purely decorative. They don't have any thoughts other than fucking each other silly. Just the way it should be.""",
      """|| bg="Slutroom/3"
        -- Looks like someone has snuck in and taken advantage of her. Excellent.""",
      """|| bg="Slutroom/4"
        -- Something is very wrong here. They have clothes - how the hell did they get those? I strip them bare immediately, of course.""",
      """|| bg="Slutroom/MF"
        -- One of my males deserved a special reward. My sluts were more than happy to oblige.""",
    ]

    if g.events.SlutroomOral
      c.push """|| bg="Slutroom/Oral1"
        -- ` Mmgmph, mmm, hmmmmm, mmmumghmph...`
        `D Carry on, don't let me interrupt. I'll just stand here and watch a while.`"""
      c.push """|| bg="Slutroom/Oral2"
        -- She's found the spot. That wonderful, sensitive little spot. And now she's tongue-fucking it."""
      c.push """|| bg="Slutroom/Oral3"
        -- If you're going to cum first, it's only fair to finish the other woman off in return."""
    if g.events.SlutroomFisting
      c.push """|| bg="Slutroom/Fisting1"
        -- That wine is going to be hell to get out of the table cloth. But totally worth it."""
      c.push """|| bg="Slutroom/Fisting2"
        -- Oh. Geeze. I didn't think she'd be able to fit both hands in there. Ouch."""
      c.push """|| bg="Slutroom/Fisting3"
        -- I bet that relieved "it fit" smile will change in a moment when the fingers start wiggling."""
    if g.events.SlutroomStrapon
      c.push """|| bg="Slutroom/Strapon1"
        -- It's not that she wanted a cock, it's that she wanted to fuck people. The distinction isn't all that subtle, guys."""
      c.push """|| bg="Slutroom/Strapon2"
        -- Look at them both, just dripping. I sneak up behind and put a finger in both asses at the same time, and as expected, the squeals are delightful."""
    if g.events.SlutroomSybian
      c.push """|| bg="Slutroom/Sybian1"
        -- Girl, you're going to have to lick that floor clean later. No-no, you can't stop. Just wanted to let you know."""
      c.push """|| bg="Slutroom/Sybian2"
        -- Truley the finest invention of the age."""
    if g.events.SlutroomCum
      c.push """|| bg="Slutroom/Cum1"
        -- I like this "internet." My kind of place. Liana, get one for everyone."""
      c.push """|| bg="Slutroom/Cum2"
        -- Sssh, don't disturb them. This is my favorite part."""

    """|| class="jobStart" auto="1800"
        <h4>Slutroom</h4>

      #{Math.choice c}
      <em class="depravity">+#{slutroomDepravity()}</em>#{if @cum then ', <span class="cum">+1</span>' else ''}
    """
  effects:
    depravity: 'depravity'
    cum: 'cum'

add class SlutroomOral extends ResearchJob
  label: "Slutroom Cunnilingus"
  progress: 100
  text: ->"""<span class="depravity">+1</span> per day for each slutroom.
    <br>With a new spell added to the occupants, they can subsist entirely off of eating each other out, no more food needed."""

add class SlutroomOral extends Page
  text: ->"""|| bg="Slutroom/Oral3"
    -- There was a young sapphic named Anna
    Who stuffed her friend's cunt with banana,
    Which she sucked bit by bit
    From her partner's warm slit,
    In the most approved lesbian manner.
  """

add class SlutroomFisting extends ResearchJob
  conditions:
    '|events|SlutroomOral': {}
  label: "Slutroom Fisting"
  progress: 200
  text: ->"""<span class="depravity">+1</span> per day for each slutroom.
    <br>Repeat after me: I want to be stretched, I want to be taken, with your fist in my cunt my mind becomes vacant."""

add class SlutroomFisting extends Page
  text: ->"""|| bg="Slutroom/Fisting1"
      -- Bridget the Midget, the dwarf who loves sucking;
      Bridget the Midget, she comes when she's fucking.
      She loves a good fisting, both active and passive;
      Believe me good sir, her holes are quite massive.
  """

add class SlutroomStrapon extends ResearchJob
  conditions:
    '|events|SlutroomFisting': {}
  label: "Slutroom Strapon"
  progress: 400
  text: ->"""<span class="depravity">+1</span> per day for each slutroom.
    <br>While my sex magic certainly gains the most from women, it also reacts well to penetration. I can give them toys, and then get the best of both worlds!"""

add class SlutroomStrapon extends Page
  text: ->"""|| bg="Slutroom/Strapon1"
    -- A pansy who lived in Cancun
      Took a lesbian up to his room,
      And they argued all night
      Over who had the right
      To do what, and with which, and to whom."""

add class SlutroomSybian extends ResearchJob
  conditions:
    '|events|SlutroomStrapon': {}
  label: "Slutroom Sybian"
  progress: 800
  text: ->"""<span class="depravity">+1</span> per day for each slutroom.
    <br>Oh. My. God. This machine that Liana showed me is the best thing ever. I need to get one for all my sluts."""

add class SlutroomSybian extends Page
  text: ->"""|| bg="Slutroom/Sybian1"
    -- The limerick’s an art form complex
      Whose contents run chiefly to sex;
        It’s famous for virgins
        And masculine urgin’s
      And vulgar erotic effects."""

add class SlutroomCum extends ResearchJob
  conditions:
    '|events|SlutroomStrapon': {}
    '|events|MoreResources': {}
  label: "Slutroom cum collection"
  progress: 200
  text: ->"""<span class="cum">+1</span> per day for each slutroom.
    <br>Why does everyone always assume I mean men when I talk about cum? Female cum is just as magically powerful and pleasant."""

add class SlutroomCum extends Page
  text: ->"""|| bg="Slutroom/Cum2"
    -- Two lesbians north of the town,
      Made sixty-nine love on the ground.
      Their unbridled lust
      Leaked out in the dust
      And made so much mud that they drowned!"""
