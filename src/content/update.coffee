Game.update.push {
  pre: ->
    delete @map.Rooms.jobs.ExtraPens
  post: ->
    for label, location of @map
      for label, job of location.jobs when job instanceof Job.Milking
        job.workers = Math.min(12, job.workers)
    return
}
Game.update.push {
  post: ->
    for name, person of @people
      person.max = new Collection(person.max)
    return
}
Game.update.push {
  post: ->
    if @events.Nudity
      @map.NorthEnd.jobs[7] = new Job.LargeRoom
    return
}
