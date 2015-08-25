trainingCost = 2
effect = ->
  e = 2
  if g.events.SexyLibrarian then e += 0.5
  if g.events.NudeLibrarian then e += 0.5
  return e

Place.Rooms::jobs.library = RoomJob.Library = class Library extends RoomJob
  label: "Library"
  size: 'medium'
  effects:
    depravity: -200
    women: -3
  conditions:
    '|events|Laboratory': {}
  text: ->"""People can train their <span class="intelligence">intelligence</span> here. Honestly, I'm not completely sure what smarts are good for, but I guess I might need smart people for something someday? It certainly makes Liana wet, so I guess intelligence isn't completely useless."""

RoomJob.Library::next = Page.Library = class Library extends Page
  text: -> """|| bg="Library/Empty.jpg"
    -- Books. Fucking books everywhere. "California" seems to produce them by the truckload. Their scribes must be amazing.
  || bg="Liana/Happy.jpg"
    --> #{q g.officers.Liana}We don't use scribes, we have these things called...</q>
  || bg="Liana/Tentacles.jpg"
    --> #{q}Ahh! Mistress...?</q>
  ||
    #{q g.officers.DarkLady}Hush dear. Don't correct me when I'm ranting.</q>
  """

RoomJob.Library::room = Job.Library = class Library extends Job
  label: "Library"
  text: -> """I really do not see the point of a library. If people are me, they're already devastatingly intelligent. If they're not, all they need to know is obedience and fucking. Sigh. Liana's giving me that <em>look</em> again. Guess I'll buy more books.
  <br><em class="intelligence">+#{effect()} Intelligence</em>"""
  officers:
    worker:
      matches: -> if g.depravity >= trainingCost then true else false
      label: -> if g.depravity >= trainingCost then '' else 'Need <span class="depravity">' + trainingCost + '</span>'
  next: Page.firstMatch

Job.Library::next = Page.LibraryDaily = class LibraryDaily extends Page
  conditions:
    worker: {}
  text: ->
    if Math.random() < 0.75  or g.events.LibraryDaily?[0] is g.day then return false
    l = [
      """|| bg="Library/Belly.jpg"
        -- "Can I help you find anything, #{if @worker.gender is 'f' then "ma'am" else 'sir'}? M-my shirt? Yes, I-I suppose, if you wish..." """,
      """|| bg="Library/Empty.jpg"
        -- Books, books, books. Heart and soul of the amazing power of "California", Liana insists, but I'm not really a fan."""
    ]
    if g.events.SexyLibrarian
      l.push """|| bg="Library/Sexy1.jpg"
        -- This librarian seems to be taking her authority to punish late books rather seriously."""
      l.push """|| bg="Library/Sexy2.jpg"
        -- It's exhausting, keeping the shelves straight when most visitors would rather fuck you than complete their assigned research."""
      l.push """|| bg="Library/Sexy3.jpg"
        -- "Stop leaving all the books out! I'm a librarian, not your mother!" """

    if g.events.NudeLibrarian
      l.push """|| bg="Library/Nude1.jpg"
        -- It's exhausting, keeping the shelves straight when most visitors would rather fuck you than complete their assigned research."""
      l.push """|| bg="Library/Nude2.jpg"
        -- "Look, I can see you're a distracted. Shall I help you relax before a bit before you get started?" """

    return """|| class="jobStart" auto="1800"
      <h4>Library</h4>
    #{Math.choice l}
      <em class="intelligence">+#{effect()} Intelligence</em>"""
  apply: ->
    super()
    @context.worker.add('intelligence', effect())

Place.Research::jobs.sexyLibrarian = RoomJob.SexyLibrarian = class SexyLibrarian extends RoomJob
  conditions:
    '|events|Library': {}
  label: "Sexy Librarians"
  progress: 350
  text: ->"""<span class="intelligence">+0.5 Intelligence</span> when training in a library.
  <br>I'd rather check out a book from a sexy librarian than I would from an unsexy one. So obvious, duh."""

RoomJob.SexyLibrarian::next = Page.SexyLibrarian = class SexyLibrarian extends Page
  text: ->"""|| bg="Library/Sexy1.jpg"
    -- The limerick's callous and crude,
    Its morals distressingly lewd;
    It's not worth the reading
    By persons of breeding -
    It's designed to be callous and rude.
  """

Place.Research::jobs.nudeLibrarian = RoomJob.NudeLibrarian = class NudeLibrarian extends RoomJob
  label: "Nude Librarians"
  progress: 700
  conditions:
    '|events|SexyLibrarian': {}
  text: ->"""<span class="intelligence">+0.5 Intelligence</span> when training in a library.
  <br>Honestly, I don't know why I let anyone wear clothes at all."""

RoomJob.NudeLibrarian::next = Page.NudeLibrarian = class NudeLibrarian extends Page
  text: ->"""|| bg="Library/Nude2.jpg"
    -- Hm. I do remember why I let people wear clothes now - if they're not wearing any, then they quickly lose their embarrassment when they have to take them off. Oh well. Guess I'll only make them take off their clothes randomly.
  """
