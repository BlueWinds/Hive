trainingDuration =
  Domme: 300
  Sadist: 300
  Maid: 300
  SexSlave: 150
trainingCost = 5
trainingBase =
  Domme: 'women'
  Sadist: 'men'
  Maid: 'virgins'
  SexSlave: 'women'

choices = ->
  c = {}
  if g.men then c.Sadist = 'Sadist'
  if g.women then c.Domme = 'Domme'
  if g.events.Maid and g.virgins then c.Maid = 'Maid'
  if g.events.SexSlave and g.women then c.SexSlave = 'Sex Slave'
  if Object.keys(c).length is 0 then c[''] = ''
  return c

Place.Rooms::jobs.training = RoomJob.TrainingChamber = class TrainingChamber extends RoomJob
  label: "Training Chamber"
  effects:
    depravity: -50
    men: -1
    women: -1
  size: 'small'
  text: ->"""Lets me train ♂ Slaves into Sadists, and ♀ Slaves into Dommes. Willing human assistants are nice, sometimes. Requires one male and female slave each, permanently installed as teaching aids. I'll also be able to research other servant types later."""

RoomJob.TrainingChamber::next = Page.TrainingChamber = class TrainingChamber extends Page
  text: -> """|| bg="TrainingChamber/WoodenHorse.jpg"
    -- The point isn't just to hurt people - that's the biggest thing I need to teach my human servants. It's to hurt people so they <em>like it</em>.
  ||
    --> Taking a fine, upstanding young woman and reducing her to a fierce mess of lust and base desires is a fine art, and this room is filled with toys... not for doing this, but for teaching others how to do it.
  """

RoomJob.TrainingChamber::room = Job.TrainingChamber = class TrainingChamber extends Job
  choice: 'Sadist'
  Domme: 0
  Sadist: 0
  Maid: 0
  SexSlave: 0

  label: "Training Chamber"
  text: ->"""Here I can train slaves into a wide variety of useful roles. <em class="depravity">-#{trainingCost}</em>

    #{dropdown choices(), @choice}: <strong>#{@[@choice] or 0} / #{trainingDuration[@choice] or 0}</strong>
    <br>Daily progress: <span class="intelligence">Int</span> + <span class="lust">1/2 Lust</span>
  """

  renderBlock: (mainKey, location)->
    unless choices()[@choice]? then @choice = Object.keys(choices())[0]
    element = $ super(mainKey, location)
    element.on 'change', 'input', =>
      @choice = $('input:checked', element).val()
    return element

  officers:
    Trainer:
      matches: (person, job)->
        if g.depravity < trainingCost or not g[trainingBase[job.choice]] then false
        else true
      label: ->
        if g.depravity < trainingCost then 'Need <span class="depravity">' + trainingCost + '</span>'
        else if not g[trainingBase[@choice]] then 'Need slave'
        else 'Trainer'

Job.TrainingChamber::next = Page.TrainingChamberDaily = class TrainingChamberDaily extends Page
  conditions:
    Trainer: {}
    job:
      path: '|last'
      matches: (job)-> job.choice
    progress: fill: -> @Trainer.intelligence + Math.floor(0.5 * @Trainer.lust)
    remaining: fill: ->
      Math.max(0, trainingDuration[@job.choice] - @job[@job.choice] - @progress)
  text: ->
    c = if @job.choice is 'Domme' then [
      """|| bg="TrainingChamber/WoodenHorse.jpg"
        -- I always figure that people should be able to take as well as dish out. They don't have to enjoy it, but they should know what it feels like at least!"""
      """|| bg="TrainingChamber/F1.jpg"
        -- You'd think the training slave would have gotten used to it by now, but no, a heel jammed in the cunt always hurts."""
      """|| bg="TrainingChamber/F2.jpg"
        -- That glorious smirk, simultaneously so superior to her victim and yet asking permission from me..."""
      """|| bg="TrainingChamber/F3.jpg"
        -- #{q g.officers.DarkLady}Honk-honk,</q> I squeeze her titties. She blushes and stammers something about "disrupting her concentration. On top of everyone else, putty in my hands - perfect."""
      """|| bg="TrainingChamber/F4.jpg" """
    ] else if @job.choice is 'Sadist' then [
      """|| bg="TrainingChamber/M1.jpg"
        -- A Sadist's training includes not only physical skills, but also mental ones. They need to be able to <em>look</em> scary."""
      """|| bg="TrainingChamber/M2.jpg"
        -- While some men are natural brutes and enjoy watching people suffer, others learn to take a bit of pride in their artistry."""
      """|| bg="TrainingChamber/M3.jpg"
        -- My very favorite sadists are those that look so innocent you can hardly believe their manic grin when they finally get to have their way with a tender little body."""
    ] else if @job.choice is 'Maid' then [
      """|| bg="TrainingChamber/Maid1.jpg"
        -- Polite! Unfailingly polite. I demand perfection in few things, but this is one of them."""
      """|| bg="TrainingChamber/Maid2.jpg"
        -- A well trained maid should be ready to bare herself to her master at any time. She must still blush, though - she's a domestic servant, not some common slut."""
      """|| bg="TrainingChamber/Maid3.jpg"
        -- She's a natural. Just look at that smile."""
      """|| bg="TrainingChamber/Maid4.jpg"
        -- Still embarrassed by how short your skirt is? Don't worry dear, you'll get over it soon. What? No, of course you can't have your underwear back."""
    ] else if @job.choice is 'SexSlave' then [
      """|| bg="TrainingChamber/Exercise.jpg"
        -- Of course not everyone is fit enough to serve me when they first arrive. A bit of magic to make their exercise go faster is more effective than forcing the whole thing magically."""
      """|| bg="TrainingChamber/SS1.jpg"
        || bg="TrainingChamber/SS2.jpg"
        || bg="TrainingChamber/SS3.jpg"
        || bg="TrainingChamber/SS4.jpg"
        || bg="TrainingChamber/SS5.jpg"
        || bg="TrainingChamber/SS6.jpg"
        """
      """|| bg="TrainingChamber/SS11.jpg"
        || bg="TrainingChamber/SS12.jpg"
        || bg="TrainingChamber/SS13.jpg"
        || bg="TrainingChamber/SS14.jpg"
        || bg="TrainingChamber/SS15.jpg"
        || bg="TrainingChamber/SS16.jpg"
        """
      """|| bg="TrainingChamber/SS21.jpg"
        -- While normally I wouldn't interfere in a slave's training, this is a special case. The girl <em>sold bras</em> for a living. I'd better hit her brain with a few carefully chosen spells to make sure she doesn't lapse back into bad habits."""
      """|| bg="TrainingChamber/SS31.jpg"
        -- Getting used to nudity is one of the primary goals in her training."""
      """|| bg="TrainingChamber/SS41.jpg"
        """
    ]
    Math.choice(c) + """

    ||
      --> <em>+#{@progress} progress (#{@remaining} remaining)<br><span class="depravity">-#{trainingCost}</span></em>"""
  apply: ->
    super()
    choice = @context.job.choice
    @context.job[choice] += @context.progress
    if not @context.remaining
      g[trainingBase[choice]] -= 1
      @context.job[choice] = 0
      g.officers.push officer = new Officer[choice]
      officer.key = (g.officers.length - 1).toString()
  effects:
    depravity: -trainingCost

Place.Research::jobs.maid = RoomJob.Maid = class Maid extends RoomJob
  label: "Train Maids"
  progress: 250
  text: ->"""Allows me to train <span class="virgins"></span> slaves into Maids at in my Training Chamber."""

RoomJob.Maid::next = Page.Maid = class Maid extends Page
  text: ->"""|| bg="Library/Sexy1.jpg"
    -- There was a young sailor from Brighton,
    Who remarked to his girl "You're a tight one."
    She replied "'Pon my soul,
    You're in the wrong hole;
    There's plenty of room in the right one."
  """

Place.Research::jobs.sexSlave = RoomJob.SexSlave = class SexSlave extends RoomJob
  conditions:
    '|events|Maid': {}
    '|events|Outreach': {}
  label: "Train Sex Slaves"
  progress: 500
  text: ->"""Allows me to train <span class="women"></span> slaves into Sex Slaves at in my Training Chamber."""

RoomJob.SexSlave::next = Page.SexSlave = class SexSlave extends Page
  text: ->"""|| bg="Library/Sexy1.jpg"
    -- I wooed a stewed nude in Bermuda,
    I was lewd but my god she was lewder.
    She said it was crude
    To be wooed in the nude -
    I pursued her, subdued her and screwed her."
  """
