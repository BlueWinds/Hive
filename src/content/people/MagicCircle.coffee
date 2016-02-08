add class Catgirl extends Person
  name: 'Catgirl'
  gender: 'f'
  strength: 5
  magic: 1
  intelligence: 0
  lust: 20
  max:
    strength: 15
    magic: 7
    intelligence: 10
    lust: 80
  description: ->"""No, they don't come off. Distractable, sexy as hell, likes to drink milk from saucers, forgets to wear clothes unless ordered. Investments in training pay very well at auction."""
  image: Person.sticky
  @images: [
    'MagicCircle/Catgirl1'
    'MagicCircle/Catgirl2'
    'MagicCircle/Catgirl3'
    'MagicCircle/Catgirl4'
    'MagicCircle/Catgirl5'
  ]

add class Catboy extends Person
  name: 'Catboy'
  gender: 'm'
  strength: 15
  magic: 1
  intelligence: 5
  lust: 10
  max:
    strength: 30
    magic: 1
    intelligence: 25
    lust: 55
  description: ->"""No, they don't come off. Distractable, sexy, likes to drink milk from saucers, much less likely to forget his own name than a catgirl."""
  image: Person.sticky
  @images: [
    'MagicCircle/Catboy1'
    'MagicCircle/Catboy2'
  ]
