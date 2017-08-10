add class BreedingPit extends RoomJob
  label: "Breeding Pit"
  size: 'large'
  conditions:
    '|tentaclesReady': is: true
    '|events|SpawningPit': {}
  effects:
    depravity: -300
    virgins: -3
    milk: -50
    cum: -40
  text: ->"""Inelegant and messy, I should nonetheless be able to relieve the weight of of my existance from Liana's shoulders by using a breeding pit as a power source. Increases both of our maximum <span class="magic">Magic</span>."""

add class BreedingPit extends Page
  text: -> """|| bg="BreedingPit/Feed"
    -- It used to be the inside of a warehouse, and technically it still. But it's a much more interesting place now, a cross between the modern mortal conceptions of heaven and hell, far more to my liking than either.
  """
  apply: ->
    super()
    g.tentaclesReady = false

add class BreedingPit extends Job
  label: "Breeding Pit"
  text: -> """I can feed the mass of tentacles a trained slave. They'll be pleasured and tormented permanently, and the magic will help sustain me.

  Fed #{@fed.toWord()} time#{if @fed is 1 then '' else 's'}
  Dark Lady: <span class="magic">#{D.max.magic} max</span>
  Liana: <span class="magic">#{L.max.magic} max</span>"""
  people:
    worker: isnt: [Person.DarkLady, Person.Liana]
  fed: 0

Job.BreedingPit::next = add class BreedingPitDaily extends Page
  conditions:
    worker: {}
    job: '|last'
  text: ->
    c = [
      """|| bg="BreedingPit/1"
        -- The chamber likes to restrain their arms so they can't pleasure themselves. It wants complete control over when - or if - they orgasm."""
      """|| bg="BreedingPit/2"
        -- Some women it likes to torment with the possibility of escape, but others it prefers not to hold back. Her womb and stomach are both flooded with cum, her orgasms continuous."""
      """|| bg="BreedingPit/31"
        -- I pause it on my inspection tour. `D She's too clean. Fix that, will you?`
      || bg="BreedingPit/32"
        --> Ah, there we go. I smile and continue on my way."""
      """|| bg="BreedingPit/4"
        -- The creature is surprisingly shy - it doesn't like to show its more specialized (and fragile) appendages to just anyone, but I'm special like that."""
      """|| bg="BreedingPit/51"
      || bg="BreedingPit/52"
      || bg="BreedingPit/51"
      || bg="BreedingPit/52"
        -- """
      """|| bg="BreedingPit/6"
        -- """
      """|| bg="BreedingPit/7"
        -- New slaves are restrained for their own safety. The thrashing of the first few hundred orgasms can be quite hard on their bodies if not held in place."""
      """|| bg="BreedingPit/81"
      || bg="BreedingPit/82"
      ||
        -- By the time the tentacles have wound their way all the way through her body and out her mouth, she's a permanent fixture of the breeding pits, impossible to remove even if I wanted to. I don't, of course."""
      """|| bg="BreedingPit/9"
        -- Crowded conditions aren't an issue with breeding pits - the sounds and smell of other women being perpetually fucked is a bonus for them, once they've accepted their new lives."""
    ]
    return Math.choice(c) + "\n<em class='magic'>+1 max Magic</em>"
  apply: ->
    super()
    @context.job.fed += 1
    delete @context.job.context.worker
    g.people.remove @context.worker

    D.max.magic = Math.min(100, D.max.magic + 1)
    L.max.magic = Math.min(100, L.max.magic + 1)
