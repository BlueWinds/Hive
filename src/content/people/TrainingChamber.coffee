sticky = Person.sticky = ->
  @imageKey or= Math.floor(Math.random() * @constructor.images.length)
  return @constructor.images[@imageKey]

add class Domme extends Person
  name: 'Domme'
  gender: 'f'
  strength: 15
  magic: 0
  intelligence: 25
  lust: 20
  max: new Collection
    strength: 20
    magic: 5
    intelligence: 50
    lust: 25
  description: ->"""Cruel and lovely, equally at home wielding a whip or a gentle kiss... a woman after my own heart."""
  image: sticky
  @images: [
    'TrainingChamber/F1'
    'TrainingChamber/F2'
    'TrainingChamber/F3'
    'TrainingChamber/F4'
  ]

add class Sadist extends Person
  name: 'Sadist'
  gender: 'm'
  strength: 25
  magic: 0
  intelligence: 15
  lust: 20
  max: new Collection
    strength: 40
    magic: 0
    intelligence: 30
    lust: 25
  description: ->"""A malicious grin and a firm conviction that women should be groveling while he fucks them... a man after my own heart."""
  image: sticky
  @images: [
    'TrainingChamber/M1'
    'TrainingChamber/M2'
    'TrainingChamber/M3'
  ]

add class Maid extends Person
  name: 'Maid'
  gender: 'f'
  strength: 5
  magic: 0
  intelligence: 10
  lust: 10
  max: new Collection
    strength: 70
    magic: 1
    intelligence: 15
    lust: 20
  description: ->"""Uniforms vary from puffy to short, lipstick varies from nonexistent to bright red, and masters vary from kind to harsh. The one thing that doesn't vary is that she'll be 'cleaning' a bit more than windows..."""
  image: sticky
  @images: [
    'TrainingChamber/Maid4'
    'TrainingChamber/Maid5'
    'TrainingChamber/Maid6'
  ]

add class SexSlave extends Person
  name: 'Sex Slave'
  gender: 'f'
  strength: 5
  magic: 0
  intelligence: 5
  lust: 35
  max: new Collection
    strength: 20
    magic: 3
    intelligence: 15
    lust: 65
  description: ->"""She has one purpose in life, and she's learned to both accept her role and love it."""
  image: sticky
  @images: [
    'TrainingChamber/SS3'
    'TrainingChamber/SS4'
    'TrainingChamber/SS5'
  ]

add class ManWhore extends Person
  name: 'Man Whore'
  gender: 'm'
  strength: 5
  magic: 0
  intelligence: 5
  lust: 35
  max: new Collection
    strength: 20
    magic: 0
    intelligence: 15
    lust: 65
  description: ->"""He's got a cock, an asshole and a mouth, and he's not afraid to have any of them used. He'd rather enjoy it, in fact."""
  image: sticky
  @images: [
    'TrainingChamber/MH1'
    'TrainingChamber/MH2'
    'TrainingChamber/MH3'
  ]
