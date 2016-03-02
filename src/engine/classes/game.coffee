window.add = (item)->
  classes = [
    [Person],
    [Place, Game::map],
    [ResearchJob, Place.Research::jobs],
    [RoomJob, Place.Rooms::jobs],
    [Job, (item)->
      if item::place then Game::map[item::place]::jobs[item.name] = item
    ],
    [Page, (item)->
      if RoomJob[item.name] then RoomJob[item.name]::next = item
      else if ResearchJob[item.name] then ResearchJob[item.name]::next = item
      else if Job[item.name] then Job[item.name]::next = item
    ]
  ]

  for [_class, location] in classes when item.prototype instanceof _class
    _class[item.name] = item
    if typeof location is 'function' then location(item)
    else if location then location[item.name] = item
    break

  return item

window.Game = class Game extends GameObject
  @schema:
    type: @
    properties:
      day:
        type: 'integer'
        gte: 0
      weather:
        type: 'string'
        match: /calm|storm/
      version:
        type: 'integer'
      depravity:
        type: 'integer'
      men:
        type: 'integer'
      women:
        type: 'integer'
      virgins:
        type: 'integer'
      milk:
        type: 'integer'
        optional: true
      cum:
        type: 'integer'
        optional: true
    strict: true
  @passDay: []
  @update: [] # Update items are in the format {pre: ()->, post: ()->}, both properties optional.

  constructor: (gameData)->
    updates = if gameData then [gameData.version or 0 ... Game.update.length] else []
    for i in updates
      Game.update[i].pre?.call(gameData)

    objects = []
    super null, objects, ''
    for item in objects
      for key, value of item when typeof value is 'string' and value[0] is '|'
        item[key] = @getItem value
    @version = Game.update.length

    unless gameData then return

    # Now we recursively copy the data into our new clean game.
    recursiveCopy.call @, @, gameData

    for i in updates
      Game.update[i].post?.call(@)
    return

  export: ->
    super [], [], ''

  day: 0
  depravity: 0
  men: 0
  women: 0
  virgins: 0
  version: 0
  mapImage: "Map"

  getItem: (path)->
    if typeof path is 'string'
      if path is '|' then return @

      path = path.split '|'
      first = path.shift()
      if first then throw new Error(first + '|' + path.join('|') + ' is a bad path')
    target = @
    for part in path
      target = target?[part]
    return target

  setGameInfo: ->
    element = $('.nav')
    $('.day', element).html @date
    $('.depravity', element).html @depravity
    $('.space', element).html "#{@men + @women + @virgins}/#{@space}"
    $('.men', element).html @men
    $('.women', element).html @women
    $('.virgins', element).html @virgins
    if @milk? then $('.milk', element).removeClass('hidden').html(@milk) else $('.milk', element).addClass('hidden')
    if @cum? then $('.cum', element).removeClass('hidden').html(@cum) else $('.cum', element).addClass('hidden')
    element.addTooltips()

  startDate = new Date(2021, 9, 31)

  Object.defineProperty @::, 'month', {get: -> months[startDate.addDays(@day).getMonth()]}
  Object.defineProperty @::, 'dayOfMonth', {get: -> startDate.addDays(@day).getDate()}
  Object.defineProperty @::, 'date',
    get: -> "#{@month} #{dayList[@dayOfMonth]}"

  applyEffects: (effects, context)->
    applyAddRemove.call(@, effects)

    for stat in ['depravity', 'virgins', 'women', 'men', 'milk', 'cum'] when effects[stat] and @[stat]?
      amount = if typeof effects[stat] is 'string' then context[effects[stat]] else effects[stat]
      if stat in ['women', 'men', 'virgins']
        amount = Math.min(amount, @freeSpace)

      g[stat] += Math.randomRound(amount)
      g[stat] = Math.max(g[stat], 0)

  Object.defineProperty @::, 'space', {get: ->
    space = 6
    for name, location of g.map
      for key, job of location.jobs when job instanceof Job.Dungeon
        space += 6
    return space
  }
  Object.defineProperty @::, 'freeSpace', {get: ->
    return Math.max(@space - g.men - g.women - g.virgins, 0)
  }
months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
dayList = [null, '1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th', '13th', '14th', '15th', '16th', '17th', '18th', '19th', '20th', '21st', '22nd', '23rd', '24th', '25th', '26th', '27th', '28th', '29th', '30th', '31st']

recursiveCopy = (obj, data)->
  for key, value of data when key isnt '_'
    if typeof value is 'object'
      _class = value._?.split '|'
      if value._ and obj[key]?.constructor.name isnt _class[1]
        try
          obj[key] =  new window[_class[0]][_class[1]] {}, [], ''
        catch e
          console.error "Unable to find window.#{_class[0]}.#{_class[1]}"
      if obj[key] instanceof GameObject or obj[key] instanceof Collection
        recursiveCopy.call @, obj[key], value
      else
        obj[key] = value
    else if typeof value is 'string' and value[0] is '|'
      obj[key] = @getItem value
    else
      obj[key] = value

applyAddRemove = (effects)->
  for key, value of effects.remove or {}
    parts = key.split '|'
    property = parts.pop()

    result = @getItem(parts.join '|')[property]
    if result?.removeAs
      result.removeAs property
    else
      delete @getItem(parts.join '|')[property]
      # If it's inherited, we set it to "false" to mark it as actually gone.
      if @getItem(parts.join '|')[property]
        @getItem(parts.join '|')[property] = false

  for key, value of effects.add or {}
    parts = key.split '|'
    property = parts.pop()
    result = if typeof value is 'function' then new value else value

    if result.addAs then result.addAs property
    else @getItem(parts.join '|')[property] = result
