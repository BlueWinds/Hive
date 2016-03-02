module.exports = [
# First the game engine
  'engine/feature-detect.coffee'
  'engine/util.coffee'
  'engine/classes/base.coffee'
  'engine/classes/game.coffee'
  'engine/classes/page.coffee'
  'engine/classes/person.coffee'
  'engine/classes/job.coffee'
  'engine/classes/place.coffee'
  'engine/gui.coffee'

# Now the game screens
  'engine/screens/load.coffee'
  'engine/screens/nextDay.coffee'
  'engine/screens/port.coffee'
  'engine/screens/setSail.coffee'
  'engine/screens/buildRoom.coffee'
  'engine/screens/research.coffee'

# Finally the content
  'content/update.coffee'

# People & Units
  'content/people/Characters.coffee'
  'content/people/TrainingChamber.coffee'
  'content/people/MagicCircle.coffee'

# Rooms
  'content/rooms/empty.coffee'
  'content/rooms/small/dungeon.coffee'
  'content/rooms/small/slutroom.coffee'
  'content/rooms/small/trainingChamber.coffee'
  'content/rooms/small/magicCircle.coffee'
  'content/rooms/small/cocoon.coffee'
  'content/rooms/medium/auction.coffee'
  'content/rooms/medium/gym.coffee'
  'content/rooms/medium/laboratory.coffee'
  'content/rooms/medium/library.coffee'
  'content/rooms/medium/outreach.coffee'
  'content/rooms/large/milking.coffee'
  'content/rooms/large/galleria.coffee'
  'content/rooms/large/spawningPit.coffee'
  'content/rooms/large/breedingPit.coffee'

# Locations
  'content/locations/HolidayInn.coffee'
  'content/locations/SycamoreStreet.coffee'
  'content/locations/CityCouncil.coffee'
  'content/locations/NorthEnd.coffee'

# Introduction
  'content/intro/introText.coffee'
]
