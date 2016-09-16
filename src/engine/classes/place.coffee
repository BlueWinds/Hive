window.Place = class Place extends GameObject
  @schema:
    type: @
    strict: true
    properties:
      name:
        type: 'string'
      image:
        type: 'string'
      description:
        type: ['string', 'function']
        maxLength: 300
      jobs:
        type: Collection
        items:
          type: [Job, 'function']
      location:
        type: 'array'
        items: [
          {type: 'integer', gte: 0, lte: 4000}
          {type: 'integer', gte: 0, lte: 3000}
        ]
      arrive: # An array of days on which the ship arrived in this port
        type: 'array'
        optional: true
        items: {type: 'integer'}
      destinations: # Where a person can sail from here, in location: distance format
        type: Collection
        items:
          type: 'integer'
          gte: 0
      firstVisit: # A page displayed when the player first visits this location
        type: Page
        optional: true
      majorPort: # If this is a place where sailors can be hired and money can be made
        eq: true
        optional: true

  jobs: new Collection
  toString: -> return @name

Game::map = new Collection
Game.schema.properties.map =
  type: Collection
  items:
    type: Place

Game.schema.properties.location =
  type: Place
