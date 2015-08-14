Officer.Dominatrix = class Dominatrix extends Officer
  name: 'Dominatrix'
  gender: 'f'
  strength: 15
  magic: 0
  intelligence: 20
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
  strength: 20
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
