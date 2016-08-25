add class VideoCameras extends ResearchJob
  label: "Video Cameras"
  progress: 400
  conditions:
    '|events|SexSlave': {}
  text: ->"""I shall put my finest minds on it. We shall work day and night until we've mastered this fearsome foes, resting not for wind nor fire nor storm nor orgy breaks. We will master the art of <em>setting the VCR clock</em> or die trying. Then and only then will the blinky numbers stop annoying me enough to allow them in my domain."""

add class VideoCameras extends Page
  text: ->"""|| bg="PornStudio/Catgirl2"
    -- There was a young whore from Kilkenny,
    Who charged two fucks for a penny,
    For half of that sum,
    You could bugger her bum,
    An economy practised by many"""

add class PornStudio extends RoomJob
  label: "Porn Studio"
  size: 'medium'
  conditions:
    '|events|VideoCameras': {}
  effects:
    depravity: -200
    men: -1
  text: ->"""Apparently there are devices which can watch people having sex, and make money? I'm not clear on the details, but it seems I can let people all over the world watch slaves fucking with these 'cameras.'"""

add class PornStudio extends Page
  text: -> """|| bg="PornStudio/2"
    -- A bed, a bunch of techno gadgets, the internet (what's an externet, I wonder?), a 50lb bucket of lube.
  || bg="PornStudio/2"
    --> We're ready to roll."""

add class PornStudio extends Job
  label: "Porn Studio"
  text: -> """Transmitting depravity around the globe... I like this 'internet' thing. The market is apparently rather crowded though, so I'll need a stand-out product if I want to whore my wares properly.

  <span class="resistance">Up to -2</span>
  #{Page.statCheckDescription('lust', 130, Job.PornStudio.next, @context)}
  """
  people:
    SexSlave:
      label: -> 'Sex Slave'
      is: [Person.SexSlave, Person.Liana]
    ManWhore:
      label: -> 'Man Whore'
      is: Person.ManWhore
      optional: true
    Domme:
      optional: true
      is: [Person.Domme, Person.DarkLady]
    Sadist:
      optional: true
      is: Person.Sadist
    Maid:
      optional: true
      is: Person.Maid
    Catgirl:
      optional: true
      is: Person.Catgirl
    Catboy:
      optional: true
      is: Person.Catboy
  stat: 'lust'
  difficulty: 120
  next: Page.statCheck
  @next: {}
  type: 'boring'

Job.PornStudio.next['bad'] = add class PornBad extends Page
  text: ->
    console.log(g.events.PornStudio, g.day)
    if $('page').length and (Math.random() < 0.5 or g.events.PornStudio?[1] is g.day) then return false
    c = [
      """|| bg="PornStudio/1"
        -- Put boobs on the internet, people will watch it. Today's production wasn't a smash hit though - somehow the chemistry just wasn't there. More variety might help."""
      """|| bg="PornStudio/2"
        -- Put boobs on the internet, people will watch it. Today's production wasn't a smash hit though - even though the quality was there, it just got burried. More variety might help."""
    ]

    return """|| class="jobStart" auto="1800"
      <h4>Porn Studio</h4>
    #{Math.choice(c)}
    <em class='depravity'>+2</em>
    """
  effects:
    depravity: 2

Job.PornStudio.next['good'] = add class PornGood extends Page
  conditions:
    SexSlave: {}
    ManWhore: {}
    Domme: {}
    Sadist: {}
    Maid: {}
    Catgirl: {}
    Catboy: {}
  text: ->
    if $('page').length and (Math.random() < 0.5 or g.events.PornStudio?[1] is g.day) then return false
    c = [
      """|| bg="PornStudio/SexSlave1"
        -- Her breasts kept popping out, and the director made her redo the shot. He gave her an artsy excuse, but really he's just going to release a compilation of her tits springing free a dozen times and the faces she made."""
      """|| bg="PornStudio/SexSlave2"
        -- ` Whores an film~ Whores on film~` The opening to our series has a new theme song. I like it."""
      """|| bg="PornStudio/SexSlave3"
        -- I'm really enjoying this new form of entertainment. I'm not going to appear on camera myself, obviously, but telling one blushing girl what to do to her friend for an eventual audience of thousands? That I can very much get behind."""
    ]
    if @ManWhore
      c.push """|| bg="PornStudio/ManWhore1"
          -- Bouncy bouncy go the titties."""
    if @Domme
      c.push """|| bg="PornStudio/Domme1"
          -- It looked so fun that the director decided to dress up join in personally."""
    if @Sadist
      c.push """|| bg="PornStudio/Sadist11"
          -- Men go "grunt"
             Tit goes "boing"
             Clit goes "buzz"
             And the whip goes "crack"
        || bg="PornStudio/Sadist12"
          -- But there's one sound
             That no one knows
             What does the slut say?
        || bg="PornStudio/Sadist13"
          --> ` Ow ow ow ow ow ow owwww`"""
    if @Maid
      c.push """|| bg="PornStudio/Maid1"
          -- Oh she blushes prettily now, but just you wait until the double penetration gang-bang scene where she's the fluffer."""
    if @Catgirl
      c.push """|| bg="PornStudio/Catgirl1"
          -- It bears repeating: the process that turns women into catgirls also drains about 50 IQ points. As one of the other slaves said... "She don' give a fuck 'bout nothin' but a fuck no more.\""""
    if @Catboy
      c.push """|| bg="PornStudio/Catboy1"
          -- Mrrow~"""

    return """|| class="jobStart" auto="1800"
      <h4>Porn Studio</h4>
    #{Math.choice(c)}
    <em><span class='depravity'>+7</span>, <span class="resistance">-1</span></em>
    """
  effects:
    depravity: 7
    resistance: -1

Job.PornStudio.next['veryGood'] = add class PornGood extends Page
  conditions:
    SexSlave: {}
    ManWhore: {}
    Domme: {}
    Sadist: {}
    Maid: {}
    Catgirl: {}
    Catboy: {}
  text: ->
    if $('page').length and (Math.random() < 0.5 or g.events.PornStudio?[1] is g.day) then return false
    c = [
      """|| bg="PornStudio/SexSlave4"
        -- The director showed her a lineup, then put on the blindfold. Incorrectly guessing whose cock she's sucking results in beatings. Correctly guessing results in fuckings. She enjoys both, so really it's a win-win situation."""
      """|| bg="PornStudio/SexSlave5"
        -- Did you know that sometimes, if you take a random girl on the street and start handing her hundred dollar bills, she'll eventually agree to be in a shoot? Watch the money disappear into her purse and... voila! A new starlet is born."""
    ]
    if @ManWhore
      c.push """|| bg="PornStudio/ManWhore2"
          -- How to make a fuckslut.
          Ingredients: Pretty young girl, half a dozen rock-hard cocks, camera.
          Let everyone simmer for 10 minutes before removing their coverings.
          Set oven to "sexy times" and leave it there for one hour.
          Enjoy your creamy nuw fuckslut."""
    if @Domme
      c.push """|| bg="PornStudio/Domme2"
          -- If she thought a female director was going to be kinder, she was sadly mistaken."""
    if @Sadist
      c.push """|| bg="PornStudio/Sadist2"
          -- Liana puts it well: `L None of that pesky morals stuff. If I wanna chain a girl up naked for 12 hours with a vibrator up her snatch and ignore her screams, being the Dark Lady's lieutenant means needing neither permission nor forgiveness.`"""
    if @Maid
      c.push """|| bg="PornStudio/Maid2"
          -- Battle Maid Strip Wrestling VIII: Cat Ear Cuntdown."""
    if @Catgirl
      c.push """|| bg="PornStudio/Catgirl2"
          -- What a marvelous suggesion someone made - just because the film <em>starts</em> indoors doesn't mean it has to stay there."""
    if @Catboy
      c.push """|| bg="PornStudio/Catboy21"
        || bg="PornStudio/Catboy22"
        || bg="PornStudio/Catboy23"
        || bg="PornStudio/Catboy24"
        || bg="PornStudio/Catboy24"
          -- Geeze, leave your camera alone with the ca for just one one minute..."""

    return """|| class="jobStart" auto="1800"
      <h4>Porn Studio</h4>
    #{Math.choice(c)}
    <em><span class='depravity'>+20</span>, <span class="resistance">-2</span></em>
    """
  effects:
    depravity: 20
    resistance: -2
