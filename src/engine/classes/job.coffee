isPage = (funct)-> funct?.prototype instanceof Page

window.Job = class Job extends Page
  @schema:
    type: @
    # Jobs are not strict - you can add additional properties to them for configuration
    properties:
      label:
        type: 'string'
      # The default is "normal" - sorted last, occurring first. Plot jobs are sorted first and occur last. Special jobs are both sorted and occur occur between "normal" and "plot"
      type:
        type: 'string'
        match: /plot|special|normal|boring/
      # conditions is used to determine whether the job shows up at all, and create an initial context. Once it has, "people" defines slots for people who must / can work the job for it to apply.
      conditions: Page.schema.properties.conditions
      text: # text is used as a small blurb, rather than its own page
        type: 'function'
      # Each person will be added to the job's context before @next is called.
      people: Page.schema.properties.conditions
      apply: # Called once when the job is run to modify the game state with the results of this job. Be absolutely sure to call super() inside this function.
        type: 'function'
        optional: true
      next: # Unlike Pages, it's required for jobs.
        type: [Page, 'function']
      context:
        # A set of objects built using this page's conditions.
        optional: true
        type: Collection

  @universal = [] # An array of jobs that can show up at any port

  type: 'normal'

  renderBlock: (mainKey, location)->
    slots = for key, conditions of @people when not conditions.hide?()
      renderSlot.call(@, key, conditions)

    return """<div class="#{@type} job clearfix" data-key="#{mainKey}" data-location="#{location}">
      <div class="col-xs-6">
        <div class="job-description">#{@text().replace(/\n/g, "<br>")}</div>
      </div>
      <ul class="job-people col-xs-6">#{slots.join ''}</ul>
    </div>"""

  updateFromDiv: (div)->
    @contextFill()
    context = @context
    for key, slot of @people
      slotDiv = $('li[data-slot="' + key + '"]', div)
      person = $('.person-info', slotDiv).attr 'data-key'
      if person
        context[key] = g.people[person]

    return context

  contextReady: ->
    for key, value of @people
      unless @context[key] or value.optional
        return false
    return @contextMatch()

  show: ->
    if @type is 'boring' then return false

    div = $.render("""|| class="jobStart" auto="1800"
      <h4>#{@label}</h4>
    """)

    div.appendTo('#content').addTooltips()
    div.not(div[0]).css 'display', 'none'
    div.data 'page', @
    return div

window.RoomJob = class RoomJob extends Job
  @schema: # Similar to a normal job, but simpler and lacking a whole lot of properties.
    type: @
    properties:
      label:
        type: 'string'
      conditions: Job.schema.properties.conditions
      text:
        type: 'function'
      apply:
        type: 'function'
        optional: true
      next:
        type: [Page, 'function']
      context:
        optional: true
        type: Collection
      effects: Page.schema.properties.effects
      room:
        type: [Job, 'boolean']
        optional: true

  renderBlock: (key)->
    disabled = if @meetCost() then '' else 'dis'
    """<div class="normal job column-block #{disabled}" data-key="#{key}" title="#{@costString()}">
      <div class="block-label">#{@label}</div>
      <div class="job-description">#{@text().replace(/\n/g, "<br>")}</div>
    </div>"""

  contextReady: -> @contextMatch()
  meetCost: ->
    for res in ['depravity', 'men', 'women', 'virgins'] when @effects?[res]
      if g[res] < -@effects[res] then return false
    return true

  costString: ->
    if @progress
      "Needs #{@progress} points"
    else
      (for res in ['depravity', 'men', 'women', 'virgins', 'cum', 'milk'] when @effects[res]
        "<span class='#{res} costPart'>#{-@effects[res]}</span>").join('')

  apply: ->
    key = g.last.context.key
    location = g.map[g.last.context.location]
    super()
    if Job[@constructor.name]
      location.jobs[key] = new Job[@constructor.name]

window.ResearchJob = class ResearchJob extends RoomJob
  @schema: # Similar to a room job, but with even fewer properties.
    type: @
    properties:
      label:
        type: 'string'
      conditions: Job.schema.properties.conditions
      text:
        type: 'function'
      context:
        optional: true
        type: Collection

renderSlot = (key, conditions)->
  name = switch
    when conditions.label then conditions.label.call(@)
    when key[0] is key[0].toUpperCase() then key
    else ''

  """<li data-slot="#{key}"><div class="worker-requirements">
    #{if name then '<div class="name">' + name + '</div>' else ''}
  </div></li>"""
