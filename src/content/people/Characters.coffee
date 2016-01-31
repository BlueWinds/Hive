Object.defineProperty window, 'D', {get: (-> g.people.DarkLady)}
Game::people.DarkLady = add class DarkLady extends Person
  key: 'DarkLady'
  name: 'Dark Lady'
  gender: 'f'
  strength: 1
  magic: 15
  intelligence: 55
  lust: 50
  image: 'misc/DarkLady'
  description: ->"""It's me. I'm going to take over the world."""
  max:
    strength: 100
    magic: 100
    intelligence: 100
    lust: 100

Object.defineProperty window, 'L', {get: (-> g.people.Liana)}
Game::people.Liana = add class Liana extends Person
  name: 'Liana'
  gender: 'f'
  strength: 15
  magic: 60
  intelligence: 50
  lust: 25
  image: 'Liana/Happy'
  description: ->"""Fucktoy #1. Quite a powerful mage, and my first lieutenant. She was kicked out of university for cheating on a test, and decided to "show them all" by summoning me. Also my favorite human, though don't tell her I said so."""
  max:
    strength: 40
    magic: 80
    intelligence: 100
    lust: 100
