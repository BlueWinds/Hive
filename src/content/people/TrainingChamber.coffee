sticky = ->
  @imageKey or= Math.floor(Math.random() * @constructor.images.length)
  return @constructor.images[@imageKey]

add class Domme extends Person
  name: 'Domme'
  gender: 'f'
  strength: 15
  magic: 0
  intelligence: 25
  lust: 20
  max:
    strength: 20
    magic: 5
    intelligence: 50
    lust: 25
  description: ->"""Cruel and lovely, equally at home wielding a whip or a gentle kiss... a woman after my own heart."""
  image: sticky
  @images: [
    'TrainingChamber/F1.jpg'
    'TrainingChamber/F2.jpg'
    'TrainingChamber/F3.jpg'
    'TrainingChamber/F4.jpg'
  ]

add class Sadist extends Person
  name: 'Sadist'
  gender: 'm'
  strength: 25
  magic: 0
  intelligence: 15
  lust: 20
  max:
    strength: 40
    magic: 5
    intelligence: 30
    lust: 25
  description: ->"""A malicious grin and a firm conviction that women should be groveling while he fucks them... a man after my own heart."""
  image: sticky
  @images: [
    'TrainingChamber/M1.jpg'
    'TrainingChamber/M2.jpg'
    'TrainingChamber/M3.jpg'
  ]

add class Maid extends Person
  name: 'Maid'
  gender: 'f'
  strength: 5
  magic: 0
  intelligence: 10
  lust: 10
  max:
    strength: 70
    magic: 5
    intelligence: 15
    lust: 20
  description: ->"""Uniforms vary from puffy to short, lipstick varies from nonexistent to bright red, and masters vary from kind to harsh. The one thing that doesn't vary is that she'll be 'cleaning' a bit more than windows..."""
  image: sticky
  @images: [
    'TrainingChamber/Maid4.jpg'
    'TrainingChamber/Maid5.jpg'
    'TrainingChamber/Maid6.jpg'
  ]

add class SexSlave extends Person
  name: 'Sex Slave'
  gender: 'f'
  strength: 5
  magic: 0
  intelligence: 5
  lust: 35
  max:
    strength: 20
    magic: 1
    intelligence: 15
    lust: 80
  description: ->"""She has one purpose in life, and she's learned to both accept her role and love it."""
  image: sticky
  @images: [
    'TrainingChamber/SS31.jpg'
    'TrainingChamber/SS41.jpg'
    'TrainingChamber/SS51.jpg'
  ]

add class ManWhore extends Person
  name: 'Man Whore'
  gender: 'm'
  strength: 5
  magic: 0
  intelligence: 5
  lust: 35
  max:
    strength: 20
    magic: 1
    intelligence: 15
    lust: 80
  description: ->"""He's got a cock, an asshole and a mouth, and he's not afraid to have any of them used. He'd rather enjoy it, in fact."""
  image: sticky
  @images: [
    'TrainingChamber/SS31.jpg'
    'TrainingChamber/SS41.jpg'
    'TrainingChamber/SS51.jpg'
  ]
