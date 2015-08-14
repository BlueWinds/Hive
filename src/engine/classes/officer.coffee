window.Officer = class Officer extends Person
  @schema:
    type: @
    strict: true
    properties:
      name:
        type: 'string'
      gender:
        type: 'string'
        pattern: /^[mf]$/
      text:
        type: 'string'
        pattern: /^#[0-9A-F]{6}$/
      description:
        # description can be a string so that random characters can have one chosen for them.
        type: ['string', 'function']
  for stat in @stats
    @schema.properties[stat] = {type: 'number', gte: 0, lte: 100}

  renderBlock: (key, classes = '')->
    classes += ' officer'
    super(key, classes)

Game.schema.properties.officers =
  type: Collection
    items:
      type: Officer
Game::officers = new Collection
