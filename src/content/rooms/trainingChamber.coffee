trainingDuration = 300
trainingCost = 5

Place.Rooms::jobs.training = RoomJob.TrainingChamber = class TrainingChamber extends RoomJob
  label: "Training Chamber"
  effects:
    depravity: -50
    men: -1
    women: -1
  size: 'small'
  text: ->"""Lets me train ♂ Slaves into Sadists, and ♀ Slaves into Dominatrices. Willing human assistants are nice, sometimes. Requires one male and female slave each, permanently installed as teaching aids."""

RoomJob.TrainingChamber::next = Page.TrainingChamber = class TrainingChamber extends Page
  text: -> """|| bg="TrainingChamber/WoodenHorse.jpg"
    -- The point isn't just to hurt people - that's the biggest thing I need to teach my human servants. It's to hurt people so they <em>like it</em>.
  ||
    --> Taking a fine, upstanding young woman and reducing her to a fierce mess of lust and base desires is a fine art, and this room is filled with toys... not for doing this, but for teaching others how to do it.
  """

RoomJob.TrainingChamber::room = Job.TrainingChamber = class TrainingChamber extends Job
  label: "Training Chamber"
  text: -> """If I assign a woman here, I'll be training one of my male slaves into a Sadist. If I assign a man to work here, I'll be training a female slave into a Dominatrix.
  <em class="depravity">-#{trainingCost}</em>
  <br>Daily progress is <span class="intelligence">Intelligence</span> + <span class="lust">1/2 Lust</span>
  Next Sadist: <strong>#{@dom} / #{trainingDuration}</strong>
  Next Dominatrix: <strong>#{@sad} / #{trainingDuration}</strong>"""
  officers:
    Trainer:
      matches: (person)->
        if g.depravity < trainingCost then false
        else if g.men and person.gender is 'f' then true
        else if g.women and person.gender is 'm' then true
        else false
      label: ->
        if g.depravity < trainingCost then 'Need <span class="depravity">' + trainingCost + '</span>'
        else if g.men and g.women then ''
        else if g.men then 'Female'
        else if g.women then 'Male'
        else 'Need slave'
  dom: 0
  sad: 0

Job.TrainingChamber::next = Page.TrainingChamberDaily = class TrainingChamberDaily extends Page
  conditions:
    Trainer: {}
    job: '|last'
    progress: fill: -> @Trainer.intelligence + Math.floor(0.5 * @Trainer.lust)
    type: fill: -> if @Trainer.gender is 'f' then 'sad' else 'dom'
    remaining: fill: -> Math.max(0, trainingDuration - @job[@type] - @progress)
  text: ->
    Math.choice([
      """|| bg="TrainingChamber/WoodenHorse.jpg"
        -- I always figure that people should be able to take as well as dish out. They don't have to enjoy it, but they should know what it feels like at least!"""
      """|| bg="TrainingChamber/F1.jpg"
        -- You'd think the training slave would have gotten used to it by now, but no, a heel jammed in the cunt always hurts.""",
      """|| bg="TrainingChamber/Exercise.jpg"
        -- Of course not everyone is fit enough to serve me when they first arrive. A bit of magic to make their exercise go faster is more effective than forcing the whole thing magically.""",
      """|| bg="TrainingChamber/M1.jpg"
        -- A #{if @Trainer.gender is 'f' then 'Dom' else 'Domme'}'s training includes not only physical skills, but also mental ones. They need to be able to <em>look</em> scary.""",
    ]) + """

    ||
      --> <em>+#{@progress} progress (#{@remaining} remaining)<br><span class="depravity">-#{trainingCost}</span></em>"""
  apply: ->
    super()
    type = @context.type
    @context.job[type] += @context.progress
    if not @context.remaining
      g[if type is 'sad' then 'men' else 'women'] -= 1
      @context.job[type] = 0
      g.officers.push officer = new classes[type]
      officer.key = (g.officers.length - 1).toString()
  effects:
    depravity: -trainingCost

classes =
  dom: Officer.Dominatrix
  sad: Officer.Sadist
