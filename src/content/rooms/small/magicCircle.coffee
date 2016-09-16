trainingDetails =
  Magic:
    cost:
      cum: 10
  Catgirl:
    duration: 200
    base: 'women'
    research: 'Cats'
    cost:
      cum: 10
      milk: 6
  Catboy:
    duration: 200
    base: 'men'
    research: 'Cats'
    cost:
      cum: 10
      milk: 6

add class BuildMagicCircle extends ResearchJob
  conditions:
    '|events|MoreResources': {}
  label: "Magic Circle"
  progress: 250
  text: ->"""Allows me to build Magic Circles, wherein women can increase their <span class="magic">magic</span>
    <br>Magic. It's the only real form of power. Liana has it. I have more of it. She bows to me, and everyone else bows to us - it's the way the world works."""

add class BuildMagicCircle extends Page
  text: ->"""|| bg="Inn/Pentagram"
    -- Nearly all men can stand adversity, but if you want to test a man's character, give him power."
    --> <em>Magic Circles are small rooms (same size as Dungeons and Slutrooms)</em>
  """

add class MagicCircle extends RoomJob
  conditions:
    '|events|BuildMagicCircle': {}
  label: "Magic Circle"
  effects:
    depravity: -350
    cum: -20
    virgins: -3
  size: 'small'
  text: ->"""People can train their <span class="magic">magic</span> here. Three virginal attendants, a purifed space, a magic circle painted in cum... even pathetic mortals ought to be able to make use of surroundings like these."""

add class MagicCircle extends Page
  text: -> """|| bg="Inn/Pentagram"
    -- `D Then you drink it, and... what's wrong?`
  || bg="Liana/Hiding"
    --> Oh dear. Oh. Dear. I've made Liana <em>blush</em>. How wonderful, I didn't think she did that any more. I pause to savor the moment. I poke her. She hides her face behind the curtain too.
    --> `L You want me to drink <em>what</em>?`
    --> `D Cum. A bucket full at least.`

    -- `L A...and it actually works? You're not just messing with me?`
    --> I laugh. `D I am always messing with you. But yes, unless you feel like devouring mortal souls, it is the only way to increase your magical power.`
    --> `L I... um... I won't...`
    --> `D Silly girl, of course you will. Now come out here and take off your clothes.`
  """

choices = ->
  c = {Magic: 'Magic'}
  for name, info of trainingDetails when g[info.base]
    if info.research and not g.events[info.research] then continue
    if (cost for cost, amount of info.cost when g[cost] < amount).length then continue
    c[name] = name
  return c

add class MagicCircle extends Job
  label: 'Magic Circle'
  choice: 'Magic'
  text: ->
    cost = (for c, amount of trainingDetails[@choice].cost
      "<span class='#{c}'>-#{amount}</span>")

    if @choice is 'Magic'
      result = ''
      cost.unshift '<em class="magic">+2 Magic</em>'
    else
      result = """#{@[@choice] or 0} / #{trainingDetails[@choice]?.duration or 0}
      <br> +#{(@context.worker?.magic + 20) or 0} daily"""

    return """Raising witches and sorceresses is hard work. Or I could to warp humans into... other things with <span class="magic">magic</span>. Decisions, decisions.

    Train #{dropdown choices(), @choice} <strong>#{result}</strong>
    <em>#{cost.join ', '}</em>"""
  type: 'boring'
  people:
    worker:
      matches: (worker, job)->
        if job.choice is 'Magic' then return worker.magic < worker.max.magic
        for c, amount of trainingDetails[job.choice].cost
          if g[c] < amount then return false
        return true
      label: ->
        for c, amount of trainingDetails[@choice].cost
          if g[c] < amount
            return 'Need <span class="' + c + '">' + amount + '</span>'
        return ''

  renderBlock: (mainKey, location)->
    unless choices()[@choice]? then @choice = Object.keys(choices())[0]
    element = $ super(mainKey, location)
    element.on 'change', 'input', =>
      @choice = $('input:checked', element).val()
    return element
  next: -> if @choice is 'Magic' then new Page.MagicCircleMagic else new Page.MagicCircleTrain

for name of trainingDetails
  Job.MagicCircle::[name] = 0

add class MagicCircleMagic extends Page
  conditions:
    worker: {}
    '|last|choice': is: 'Magic'
  text: ->
    if $('page').length and (Math.random() < 0.5 or g.events.MagicCircleMagic?[0] is g.day) then return false

    c = [
      """|| bg="MagicCircle/1"
        -- A few women get really into it. Ok, well, not really "a few." More like "almost all." """,
      """|| bg="MagicCircle/2"
        -- Good for your complexion. Nothing beats a cum bath for relaxing after a long day.""",
      """|| bg="MagicCircle/3"
        -- Such a cute expression. It's still cum though, and drinking more than a liter of it still makes you slut, no matter how elegant you look doing so.""",
    ]
    if @worker is D
      c = ["""|| bg="Inn/Pentagram"
        -- Humans and the other mortal races get to drink cum or bathe in it, surrounded by chanting virgins and burning incense.
        I'm not human. Though stealing power in dribbles like this is slow, it does attract somewhat less attention than rising up on a throne of flame and consuming the souls of everyone who comes within a hundred miles. I learned my lesson last time."""]

    return """|| class="jobStart" auto="1800"
      <h4>Magic Circle</h4>
    #{Math.choice c}
      <em class="magic">+2 Magic</em>
      <em class="cum">-#{trainingDetails.Magic.cost.cum}</em>"""
  apply: ->
    super()
    @context.worker.add('magic', 2)
  effects:
    cum: -trainingDetails.Magic.cost.cum

add class MagicCircleTrain extends Page
  conditions:
    worker: {}
    job: '|last'
    progress: fill: -> @worker.magic + 20
    remaining: fill: -> Math.max(0, trainingDetails[@job.choice].duration - @job[@job.choice] - @progress)
  text: ->
    if $('page').length and Math.random() < 0.75 and @remaining then return false

    c = if @job.choice is 'Catgirl' then [
      """|| bg="MagicCircle/Catgirl1"
        -- Mrrow."""
      """|| bg="MagicCircle/Catgirl2"
        -- Good kitty, presenting for your mistress, holes ready for use and miscevious grin."""
      """|| bg="MagicCircle/Catgirl3"
        -- Rrrrrow."""
      """|| bg="MagicCircle/Catgirl5"
        -- I think her brains are leaking out of her ears. But that's ok, she doesn't need brains when she's got ears like that."""
    ] else if @job.choice is 'Catboy' then [
      """|| bg="MagicCircle/Catboy1"
        -- Unlike the catgirl transformation, catboys manage to retain most of their education and intelligence. Also their sense of modesty. Come on, I can't check the health of your tail unless you take those pants off."""
      """|| bg="MagicCircle/Catboy2"
        -- Don't look so sad, kitty. You'll enjoy your new life more than you ever did your old. Here, have some yarn to play with."""
    ]

    cost = (for co, amount of trainingDetails[@job.choice].cost
      "<span class='#{co}'>-#{amount}</span>").join ', '

    """|| class="jobStart" auto="1800"
        <h4>Magic Circle</h4>

      #{Math.choice(c)}
        <em>#{@progress} progress (#{@remaining} more needed)<br>#{cost}</em>"""

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
    e = {}
    for c, amount of trainingDetails[@context.job.choice].cost
      e[c] = -amount
    g.applyEffects e

add class Cats extends ResearchJob
  conditions:
    '|events|MagicCircle': {}
  label: "Train Catgirls and Catboys"
  progress: 150
  text: ->"""Allows me to warp <span class="men"></span> and <span class="women"></span> slaves into Catboys and Catgirls at the Magic Circle."""

add class Cats extends Page
  text: ->"""|| bg="MagicCircle/Catgirl1"
    -- Said the girl who was known as TX
      "My life's gotten way too complex.
      There's girls and there's boys,
      And all of my toys,
      It's tough this addiction to sex."
  """
