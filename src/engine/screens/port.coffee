updateJob = (jobDiv)->
  unless jobDiv.length then return
  job = jobDiv.data('job')
  workers = {}

  index = jobDiv.parent().children().index jobDiv
  divs = jobDiv.add $('.job-tabs li', jobDiv.closest('page')).eq index
  divs.removeClass('ready half-ready')
  $('.person-info', jobDiv).each ->
    key = $(@).attr('data-key')
    person = g.officers[key]
    workers[key] = person
  job.updateFromDiv(jobDiv)
  if job.contextReady()
    divs.addClass 'ready'
  else if $('.person-info', jobDiv).length
    divs.addClass 'half-ready'

  newText = $(job.renderBlock()).find('.job-description')
  $('.job-description', jobDiv).replaceWith(newText).addTooltips()

  jobDiv.closest('page').removeClass('confirm')
  jobDiv.closest('page').find('options').tooltip('hide')

  $('input', jobDiv).change -> setTimeout(->
    updateJob jobDiv
  , 0)

ordering =
  plot: 0
  special: 1
  normal: 2
  boring: 3

Job.jobSort = (j1, j2)->
  t1 = $(j1).data('job').type
  t2 = $(j2).data('job').type
  return ordering[t1] - ordering[t2]

Page.Port = class Port extends Page
  conditions:
    port: '|location'
  text: ->
    jobs = $('')
    jobLabels = $('')

    locs = Object.keys(g.map.HolidayInn.destinations)
    locs.push 'HolidayInn'
    for l in locs
      [j, jl] = getJobDivs(g.map[l].jobs, l)
      if g.map[l] isnt @port
        jl.addClass('hidden')
      jobs = jobs.add j
      jobLabels = jobLabels.add jl

    jobs = Array::sort.call(jobs, Job.jobSort)
    jobLabels = Array::sort.call(jobLabels, Job.jobSort)

    officers = (for key, person of g.officers
      person.renderBlock(key)
    ).sort (a, b)->
      a = g.officers[a.match(/data-key="(.*?)"/)[1]]
      b = g.officers[b.match(/data-key="(.*?)"/)[1]]
      (b.strength + b.magic + b.intelligence + b.lust) - (a.strength + a.magic + a.intelligence + a.lust)

    form = """<form class="clearfix">
      <div class="col-md-2">
        <ul class="job-tabs list-group"></ul>
      </div>
      <div class="col-lg-4 col-md-5">
        <div class="jobs column-block"></div>
      </div>
      <div class="col-lg-4 col-md-5">
        <div class="crew clearfix column-block">#{officers.join('')}</div>
      </div>
    </form>""".replace(/\n/g, '')

    page = $.render """|| class="screen" bg="<img src="#{@port.image}"
      #{form}
      --.
        #{@port.description?() or @port.description}
        #{options ['Done', 'Change Location'], ['', '']}
    """
    $('.jobs', page).append(jobs)
    $('.job-tabs', page).append(jobLabels)
    for div in jobs
      location = $(div).attr('data-location')
      job = g.map[location].jobs[$(div).attr('data-key')]
      for key, conditions of job.officers when job.context[key]?.matches conditions, job
        slot = $('.job-officers li[data-slot="' + key + '"]', div)
        person = job.context[key]
        person = $('.person-info[data-key="' + (if person.key? then person.key else person.name) + '"]', page)
        person.prependTo(slot)
    $('.job', page).each ->
      updateJob $(@)

    applyPort.call @, page
    return page

  next: false

getJobDivs = (jobs, location)->
  jobDivs = $('')
  jobLabels = $('')

  maybeAddJob = (key, job)->
    unless job.contextMatch() then return

    jobDivs = jobDivs.add job.renderBlock(key, location)
    jobDivs.last().data 'job', job
    jobLabels = jobLabels.add """<li class="#{job.type or 'normal'} list-group-item #{if job.isNew() then 'new' else ''}">#{job.label}</li>"""
    jobLabels.last().data 'job', job

  for key, job of jobs when job instanceof Job or job.prototype instanceof Job
    if typeof job is 'function'
      job = jobs[key] = new job
    maybeAddJob(key, job)

  for job, key in Job.universal
    maybeAddJob(key, new job)

  return [jobDivs, jobLabels]

applyPort = (element)->
  active = $('.job-tabs li', element).not('.hidden').first().addClass 'active'
  job = active.data('job')
  $('.job', element).each ->
    if $(@).data('job') is job
      $(@).addClass 'active'
      return false
  $('.job-tabs li', element).click ->
    $('.job, .job-tabs li', element).removeClass 'active'
    $(@).addClass 'active'
    idx = $('.job-tabs li', element).index @
    $('.job', element).eq(idx).addClass 'active'
    setTall.call(element)
  setTimeout setTall.bind(element), 0

  $('options', element).tooltip({
    title: "Some jobs haven't met their requirements. Click again to continue anyway."
    placement: 'top'
    trigger: 'manual'
  })

  people = $('.person-info', element)
  people.click -> $(@).toggleClass 'active'

  $('.job', element).click (e)->
    # If we click inside a person-div, then activate / deactivate them, but don't move everyone else.
    if $(e.target).closest('.person-info').length then return
    if $(e.target).filter('button, input, label').length then return

    jobDiv = $(@)
    job = jobDiv.data 'job'
    $('.person-info.active', element).each ->
      personDiv = $(@)
      if personDiv.closest(jobDiv).length then return
      assignPersonToJob(personDiv, job, jobDiv)
    updateJob(jobDiv)

  $('.job', element).dblclick jobDoubleClick

  # Move all active crew back into holding, then update the jobs they may have been removed from
  $('.crew', element).click (e)->
    if $(e.target).closest('.person-info').length
      return
    if $('.person-info.active', element).length
      $('.person-info.active', element).appendTo @
      .removeClass('active')
    $('.job', element).each ->
      jobDiv = $(@)
      updateJob(jobDiv)

  # The page has been rendered. Once the player clicks "done", start the day.
  $('button', element).last().prev().click doWorkClick

  $('button', element).last().click (e)->
    e.preventDefault()
    (new Page.SetSail).show()
    setTimeout(Game.gotoPage, 0)
    return false

  return element

setTall = ->
  if $('.job.active', @).height() < $('.job-tabs', @).height()
    @addClass('tall-tabs')
  else
    @removeClass('tall-tabs')

assignPersonToJob = (personDiv, job, jobDiv)->
  key = personDiv.attr('data-key')
  person = g.officers[key] or g.crew[key]

  if personDiv.hasClass('injured') and not job.acceptInjured
    return

  # Find an unoccupied slot that the person matches, and put them there.
  slot = person instanceof Officer and Collection::findIndex.call job.officers, (conditions, key)->
    slotDiv = $('li[data-slot="' + key + '"]', jobDiv)
    return $('.person-info', slotDiv).length is 0 and person.matches(conditions, job)

  slot = if slot
    $('li[data-slot="' + slot + '"]', jobDiv)
  else
    $('.job-crew', jobDiv)

  if slot.length
    personDiv.removeClass('active')

    prevJobDiv = personDiv.closest '.job'
    slot.prepend(personDiv)
    updateJob(prevJobDiv)

doWorkClick = (e)->
  e.preventDefault()
  element = $(e.target).closest 'page'

  $('.jobs > div', element).each ->
    jobDiv = $(@)
    job = jobDiv.data('job')
    # A job is valid if all of its non-optional slots are filled.
    job.updateFromDiv(jobDiv)
    if job.contextReady()
      # The job is good, shift it into the "upcoming pages" array. This reverses the ordering, so "normal" jobs come first, then special ones, then plot.
      g.queue.unshift(job)

  g.queue.push new Page.NextDay
  g.queue.push new (g.location.constructor.port or Page.Port)
  # All jobs have now been processed. Trigger the first one.
  setTimeout(Game.gotoPage, 0)
  return false

jobDoubleClick = (e)->
  if $(e.target).closest('.person-info').length then return

  page = $(@).closest('page')
  if slot = $(e.target).closest('li').attr('data-slot')
    if worker = g.getItem($(@).data('job').officers[slot])
      person = $('.person-info[data-key="' + (worker.key or worker.name) + '"]', page)
      person.addClass 'active'
  $('.crew .person-info').addClass 'active'
  $(@).click()
  $('.crew .person-info').removeClass 'active'
  # Now that all the crew-elements are in the right spot, update the job's context with its new workers, any maybe mark it as ready to go.
  updateJob $(@)
