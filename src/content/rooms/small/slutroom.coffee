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
  || bg="Slutroom/Bed.jpg"
    --> A bed.
  || bg="Slutroom/Food.jpg"
    --> An enchanted plate of self-renewing food.
  || bg="Slutroom/1.jpg"
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
  text: ->
    if Math.random() < 0.75 or g.events.SlutroomDaily?[0] is g.day then return false
    c = [
      """|| bg="Slutroom/1.jpg"
        -- I poke my head in for a moment, but all is as it should be, horny and wet and mindless.""",
      """|| bg="Slutroom/2.jpg"
        -- The chains are purely decorative. They don't have any thoughts other than fucking each other silly. Just the way it should be.""",
      """|| bg="Slutroom/3.jpg"
        -- Looks like someone has snuck in and taken advantage of her. Excellent.""",
      """|| bg="Slutroom/4.jpg"
        -- Something is very wrong here. They have clothes - how the hell did they get those? I strip them bare immediately, of course.""",
      """|| bg="Slutroom/mf.jpg"
        -- One of my males deserved a special reward. My sluts were more than happy to oblige.""",
    ]

    """|| class="jobStart" auto="1800"
        <h4>Slutroom</h4>

      #{Math.choice c}
    """
  effects:
    depravity: 'depravity'

add class SlutroomOral extends ResearchJob
  label: "Slutroom Cunnilingus"
  progress: 100
  text: ->"""<span class="depravity">+1</span> per day for each slutroom.
    <br>With a new spell added to the occupants, they can subsist entirely off of eating each other out, no more food needed."""

add class SlutroomOral extends Page
  text: ->"""|| bg="Slutroom/Oral3.jpg"
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
  text: ->"""|| bg="Slutroom/Fisting1.jpg"
      -- Bridget the Midget, the dwarf who loves sucking;
      Bridget the Midget, she comes when she's fucking.
      She loves a good fisting, both active and passive;
      Believe me, her botty-hole is quite massive.
  """

add class SlutroomStrapon extends ResearchJob
  conditions:
    '|events|SlutroomFisting': {}
  label: "Slutroom Strapon"
  progress: 400
  text: ->"""<span class="depravity">+1</span> per day for each slutroom.
    <br>While my sex magic certainly gains the most from women, it also reacts well to penetration. I can give them toys, and then get the best of both worlds!"""

add class SlutroomStrapon extends Page
  text: ->"""|| bg="Slutroom/Strapon1.jpg"
    -- A pansy who lived in Khartoum
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
  text: ->"""|| bg="Slutroom/Sybian1.jpg"
    -- The limerick’s an art form complex
      Whose contents run chiefly to sex;
        It’s famous for virgins
        And masculine urgin’s
      And vulgar erotic effects."""
