Officer.Dominatrix = class Dominatrix extends Officer
  name: 'Dominatrix'
  gender: 'f'
  strength: 15
  magic: 0
  intelligence: 25
  lust: 20
  description: ->"""Cruel and lovely, equally at home weilding a whip or a gentle kiss... a woman after my own heart."""
  image: ->
    @imageKey or= Math.floor(Math.random() * @constructor.images.length)
    return @constructor.images[@imageKey]
  @images: [
    'TrainingChamber/F1.jpg'
    'TrainingChamber/F2.jpg'
    'TrainingChamber/F3.jpg'
    'TrainingChamber/F4.jpg'
  ]

Officer.Sadist = class Sadist extends Officer
  name: 'Sadist'
  gender: 'm'
  strength: 25
  magic: 0
  intelligence: 15
  lust: 20
  description: ->"""A malicious grin and a firm conviction that women should be groveling while he fucks them... a man after my own heart."""
  image: ->
    @imageKey or= Math.floor(Math.random() * @constructor.images.length)
    return @constructor.images[@imageKey]
  @images: [
    'TrainingChamber/M1.jpg'
    'TrainingChamber/M2.jpg'
    'TrainingChamber/M3.jpg'
  ]

Officer.Maid = class Maid extends Officer
  name: 'Maid'
  gender: 'f'
  strength: 5
  magic: 0
  intelligence: 10
  lust: 15
  description: ->"""Uniforms vary from puffy to short, lipstick varies from nonexistant to bright red, and masters vary from kind to harsh. The one thing that doesn't vary is that she'll be 'cleaning' a bit more than windows..."""
  image: ->
    @imageKey or= Math.floor(Math.random() * @constructor.images.length)
    return @constructor.images[@imageKey]
  @images: [
    'TrainingChamber/Maid4.jpg'
    'TrainingChamber/Maid5.jpg'
    'TrainingChamber/Maid6.jpg'
  ]

Officer.SexSlave = class SexSlave extends Officer
  name: 'Sex Slave'
  gender: 'f'
  strength: 5
  magic: 0
  intelligence: 5
  lust: 35
  description: ->"""She has one purpose in life, and she's learned to both accept her role and love it."""
  image: ->
    @imageKey or= Math.floor(Math.random() * @constructor.images.length)
    return @constructor.images[@imageKey]
  @images: [
    'TrainingChamber/SS31.jpg'
    'TrainingChamber/SS41.jpg'
    'TrainingChamber/SS51.jpg'
  ]
