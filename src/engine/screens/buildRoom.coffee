Page.EmptyRoom = class EmptyRoom extends Page
  text: ->
    jobs = $('')
    for job, key in @asArray()
      jobs = jobs.add job.renderBlock(key)
      jobs.last().data 'job', job

    Array::sort.call(jobs, Job.jobSort)

    page = $.render """|| speed="slow" class="screen sail" bg="misc/emptyRoom"
      <div class="col-xs-8 col-xs-offset-2"></div>
    """
    $('.col-xs-8', page).append jobs
    jobs.wrap('<div class="col-xs-6"></div>')

    return roomClick page

  apply: ->
    for key, job of g.map.Rooms.jobs when job instanceof Job or job.prototype instanceof Job
      if typeof job is 'function'
        job = g.map.Rooms.jobs[key] = new job
      job.contextFill()
      unless job.size is g.last.size and job.contextMatch()
        continue
      @context.push job

    # Add the key of the job that triggered this to the context, so the RoomJob knows which job to replace
    for locKey, location of g.map
      for key, job of location.jobs when job is g.last
        @context.key = key
        @context.location = locKey

    super()
  next: false

roomClick = (element)->
  $('.job', element).click (e)->
    if $(@).hasClass('dis') then return
    e.preventDefault()
    g.queue.unshift $(@).data('job')

    Game.gotoPage()
    return false

  return element

Place.Rooms = Game::map.Rooms = class Rooms extends Place
  name: 'Empty Rooms'
  description: -> false
  image: 'misc/emptyRoom'

  destinations: new Collection
  jobs: new Collection # Unlike normal locations, this collection takes RoomJobs rather than normal Jobs
  location: [0, 0]
