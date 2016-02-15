Game.schema.properties.goal =
  type: Job
  optional: true

Page.ResearchChoice = class ResearchChoice extends Page
  text: ->
    if g.goal
      research(g.goal, @progress)
      return false

    unless @asArray().length
      return false

    jobs = $('')
    for job, key in @asArray()
      jobs = jobs.add job.renderBlock(key)
      jobs.last().data 'job', job

    Array::sort.call(jobs, Job.jobSort)


    page = $.render """|| speed="slow" class="screen sail" bg="Laboratory/1"
      <div class="col-xs-8 col-xs-offset-2 clearfix no-float"></div>
    """
    $('.col-xs-8', page).append jobs
    jobs.wrap('<div class="col-xs-6"></div>')

    progress = @progress
    $('.job', page).click (e)->
      e.preventDefault()
      job = $(@).data('job')
      research(job, progress)
      Game.gotoPage()
      return false

    return page

  apply: ->
    @context.progress = -Page.Laboratory.researchProgress(g.last.context.researcher)

    for key, job of g.map.Research.jobs when job instanceof Job or job.prototype instanceof Job
      if typeof job is 'function'
        job = g.map.Research.jobs[key] = new job
      job.contextFill()
      unless job.progress and job.contextMatch()
        continue
      @context.push job
      job.key = key

    super()
  next: false
  effects:
    depravity: 'progress'

research = (job, progress)->
  g.goal = job
  job.progress += Math.min(g.depravity, progress) * 2

  if job.progress > 0
    g.queue.unshift new Page.ResearchContinues
  else
    g.queue.unshift job
    g.goal.progress = 0
    delete g.goal
    g.map.Research.jobs[job.key] = false

Place.Research = Game::map.Research = class Research extends Place
  name: 'Research Options'
  description: -> false
  image: 'misc/emptyRoom'

  destinations: new Collection
  jobs: new Collection # Unlike normal locations, this collection takes ResearchJobs rather than normal Jobs
  location: [0, 0]

Page.ResearchContinues = class ResearchContinues extends Page
  text: ->"""|| bg="Laboratory/#{Math.choice ['1', '2']}"
    -- Research continues on #{g.goal.label}. #{g.goal.progress} points remaining."""
