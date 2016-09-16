trainingCost = 7
trainingDetails =
  Sadist:
    duration: 300
    base: 'men'
  Domme:
    duration: 300
    base: 'women'
  Maid:
    duration: 300
    base: 'virgins'
    research: 'Maid'
  'Sex Slave':
    duration: 150
    base: 'women'
    research: 'SexSlave'
  'Man Whore':
    duration: 200
    base: 'men'
    research: 'ManWhore'

choices = ->
  c = {}
  for name, info of trainingDetails when g[info.base]
    if info.research and not g.events[info.research] then continue
    c[name] = name
  if Object.keys(c).length is 0 then c[''] = ''
  return c

add class TrainingChamber extends RoomJob
  label: "Training Chamber"
  effects:
    depravity: -50
    men: -1
    women: -1
  size: 'small'
  text: ->"""Lets me train ♂ Slaves into Sadists, and ♀ Slaves into Dommes. Willing human assistants are nice, sometimes. Requires one male and female slave each, permanently installed as teaching aids. I'll also be able to research other servant types later."""

add class TrainingChamber extends Page
  text: -> """|| bg="TrainingChamber/WoodenHorse"
    -- The point isn't just to hurt people - that's the biggest thing I need to teach my human servants. It's to hurt people so they <em>like it</em>.
    --> Taking a fine, upstanding young woman and reducing her to a fierce mess of lust and base desires is a fine art, and this room is filled with toys... not for doing this, but for teaching others how to do it.
  """

add class TrainingChamber extends Job
  choice: 'Sadist'

  label: "Training Chamber"
  type: 'boring'
  text: ->"""Here I can train slaves into a wide variety of useful roles. <em class="depravity">-#{trainingCost}</em>

    #{dropdown choices(), @choice}: <strong>#{@[@choice] or 0} / #{trainingDetails[@choice]?.duration or 0}</strong>
    <br>Daily progress: <span class="intelligence">Int</span> + <span class="lust">1/2 Lust</span>
  """

  renderBlock: (mainKey, location)->
    unless choices()[@choice]? then @choice = Object.keys(choices())[0]
    element = $ super(mainKey, location)
    element.on 'change', 'input', =>
      @choice = $('input:checked', element).val()
    return element

  people:
    trainer:
      matches: (person, job)->
        if g.depravity < trainingCost then false
        else true
      label: ->
        if g.depravity < trainingCost then 'Need <span class="depravity">' + trainingCost + '</span>'
        else ''

for name of trainingDetails
  Job.TrainingChamber::[name] = 0

Job.TrainingChamber::next = add class TrainingChamberDaily extends Page
  conditions:
    trainer: {}
    '|last': matches: (job)-> job.choice
    job: '|last'
    progress: fill: -> @trainer.intelligence + Math.floor(0.5 * @trainer.lust)
    remaining: fill: -> Math.max(0, trainingDetails[@job.choice]?.duration - @job[@job.choice] - @progress) or 0
  text: ->
    # Unlike most "boring" events, these are independent of each other.
    if $('page').length and Math.random() < 0.75 and @remaining then return false
    c = if @job.choice is 'Domme' then [
      """|| bg="TrainingChamber/WoodenHorse"
        -- I always figure that people should be able to take as well as dish out. They don't have to enjoy it, but they should know what it feels like at least!"""
      """|| bg="TrainingChamber/F1"
        -- You'd think the training slave would have gotten used to it by now, but no, a heel jammed in the cunt always hurts."""
      """|| bg="TrainingChamber/F2"
        -- That glorious smirk, simultaneously so superior to her victim and yet asking permission from me..."""
      """|| bg="TrainingChamber/F3"
        -- `D Honk-honk,` I squeeze her titties. She blushes and stammers something about "disrupting her concentration. Dominant with everyone else, putty in my hands - perfect."""
      """|| bg="TrainingChamber/F4"
        --"""
      """|| bg="TrainingChamber/F5"
        -- We threw our newest dominatrix a graduation party with some of the male slaves. Poor things. I don't think they knew what they were getting into."""
    ] else if @job.choice is 'Sadist' then [
      """|| bg="TrainingChamber/M1"
        -- A Sadist's training includes not only physical skills, but also mental ones. They need to be able to <em>look</em> scary."""
      """|| bg="TrainingChamber/M2"
        -- While some men are natural brutes and enjoy watching people suffer, others learn to take a bit of pride in their artistry."""
      """|| bg="TrainingChamber/M3"
        -- My very favorite sadists are those that look so innocent you can hardly believe their manic grin when they finally get to have their way with a tender little body."""
    ] else if @job.choice is 'Maid' then [
      """|| bg="TrainingChamber/Maid1"
        -- Polite! Unfailingly polite. I demand perfection in few things, but this is one of them."""
      """|| bg="TrainingChamber/Maid2"
        -- A well trained maid should be ready to bare herself to her master at any time. She must still blush, though - she's a domestic servant, not some common slut."""
      """|| bg="TrainingChamber/Maid3"
        -- She's a natural. Just look at that smile."""
      """|| bg="TrainingChamber/Maid4"
        -- Still embarrassed by how short your skirt is? Don't worry dear, you'll get over it soon. What? No, of course you can't have your underwear back."""
    ] else if @job.choice is 'Sex Slave' then [
      """|| bg="TrainingChamber/Exercise"
        -- Of course not everyone is fit enough to serve me when they first arrive. A bit of magic to make their exercise go faster is more effective than forcing the whole thing magically."""
      """|| bg="TrainingChamber/SS1"
        || bg="TrainingChamber/SS2"
        || bg="TrainingChamber/SS3"
        || bg="TrainingChamber/SS4"
        || bg="TrainingChamber/SS5"
        || bg="TrainingChamber/SS6"
        || bg="TrainingChamber/SS6"
          -- """
      """|| bg="TrainingChamber/SS11"
        || bg="TrainingChamber/SS12"
        || bg="TrainingChamber/SS13"
        || bg="TrainingChamber/SS14"
        || bg="TrainingChamber/SS15"
        || bg="TrainingChamber/SS16"
        || bg="TrainingChamber/SS16"
          -- """
      """|| bg="TrainingChamber/SS21"
        -- While normally I wouldn't interfere in a slave's training, this is a special case. The girl <em>sold bras</em> for a living. How perverted. I'd better hit her brain with a few carefully chosen spells to make sure she doesn't lapse back into bad habits."""
      """|| bg="TrainingChamber/SS31"
        -- Getting used to nudity is one of the primary goals in her training."""
    ] else if @job.choice is 'Man Whore' then [
      """|| bg="TrainingChamber/Maid1"
        -- Polite! Unfailingly polite. I demand perfection in few things, but this is one of them."""
      """|| bg="TrainingChamber/Maid2"
        -- A well trained maid should be ready to bare herself to her master at any time. She must still blush, though - she's a domestic servant, not some common slut."""
      """|| bg="TrainingChamber/Maid3"
        -- She's a natural. Just look at that smile."""
      """|| bg="TrainingChamber/Maid4"
        -- Still embarrassed by how short your skirt is? Don't worry dear, you'll get over it soon. What? No, of course you can't have your underwear back."""
    ]

    """|| class="jobStart" auto="1800"
        <h4>Training Chamber</h4>

      #{Math.choice(c)}
        <em>#{@progress} progress (#{@remaining} more needed)<br><span class="depravity">-#{trainingCost}</span></em>"""
  apply: ->
    super()
    choice = @context.job.choice
    @context.job[choice] += @context.progress
    if not @context.remaining
      e = {}
      e[trainingDetails[choice].base] = -1
      g.applyEffects e

      @context.job[choice] = 0
      g.people.push person = new Person[choice.replace(/ /g, '')]
      person.key = (g.people.length - 1).toString()
  effects:
    depravity: -trainingCost

add class Maid extends ResearchJob
  label: "Train Maids"
  progress: 250
  text: ->"""Allows me to train <span class="virgins"></span> slaves into Maids in my Training Chamber."""

add class Maid extends Page
  text: ->"""|| bg="Library/Sexy1"
    -- There was a young sailor from Brighton,
    Who remarked to his girl "You're a tight one."
    She replied "'Pon my soul,
    You're in the wrong hole;
    There's plenty of room in the right one."
  """

add class SexSlave extends ResearchJob
  conditions:
    '|events|Maid': {}
    '|events|Outreach': {}
  label: "Train <span class='women'></span> Sex Slaves"
  progress: 500
  text: ->"""Allows me to train <span class="women"></span> slaves into Sex Slaves in my Training Chamber."""

add class SexSlave extends Page
  text: ->"""|| bg="Library/Sexy1"
    -- I wooed a stewed nude in Bermuda,
    I was lewd but my god she was lewder.
    She said it was crude
    To be wooed in the nude -
    I pursued her, subdued her and screwed her."
  """

add class ManWhore extends ResearchJob
  conditions:
    '|events|Maid': {}
    '|events|Outreach': {}
  label: "Train <span class='men'></span> Sex Slaves"
  progress: 500
  text: ->"""Allows me to train <span class="men"></span> slaves into Man Whores in my Training Chamber."""

add class ManWhore extends Page
  text: ->"""|| bg="Library/Sexy1"
    -- The president's loud protestation,
    On his fall to the intern's temptation:
    "This affair is still moral,
    As long as it's oral.
    Straight screwing I save for the nation."
  """
