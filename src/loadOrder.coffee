module.exports = [
# First the game engine
  'engine/feature-detect.coffee'
  'engine/util.coffee'
  'engine/classes/base.coffee'
  'engine/classes/game.coffee'
  'engine/classes/page.coffee'
  'engine/classes/person.coffee'
  'engine/classes/officer.coffee'
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
  'content/people/DarkLady.coffee'
  'content/people/Liana.coffee'
  'content/people/TrainingChamber.coffee'

# Rooms
  'content/rooms/empty.coffee'
  'content/rooms/slutroom.coffee'
  'content/rooms/dungeon.coffee'
  'content/rooms/trainingChamber.coffee'
  'content/rooms/gym.coffee'
  'content/rooms/library.coffee'
  'content/rooms/laboratory.coffee'
  'content/rooms/outreach.coffee'
  'content/rooms/auction.coffee'

# Locations
  'content/locations/HolidayInn.coffee'
  'content/locations/SycamoreStreet.coffee'

# Introduction
  'content/intro/introText.coffee'
]
