Game.update.push {
  pre: ->
    delete @map.Rooms.jobs.ExtraPens
  post: ->
    for label, location of @map
      for label, job of location.jobs when job instanceof Job.Milking
        job.workers = Math.min(12, job.workers)
    return
}
