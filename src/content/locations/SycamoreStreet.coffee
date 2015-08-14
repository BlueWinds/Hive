Place.Sycamore = Game::map.Sycamore = class Sycamore extends Place
  name: 'Sycamore Street'
  description: "Empty businesses, boarded up windows, hookers, broken bottles... it's not much, it's a place to start."
  image: 'Sycamore/Street.jpg'
  jobs: new Collection
  location: [633, 354]
  destinations: new Collection
    HolidayInn: -1

Place.Sycamore::jobs.streetCatch = Job.StreetCatch = class StreetCatch extends Job
  officers:
    worker: {}
  label: 'Catch Slaves'
  text: ->"""Snatching people off the street is the simplest - but also most dangerous - way to get new slaves.

  #{Page.statCheckDescription('strength', 30, Page.StreetCatch.next, @context)}"""

Job.StreetCatch::next = Page.StreetCatch = class StreetCatch extends Page
  conditions:
    worker: {}
  text: ->false
  stat: 'strength'
  difficulty: 30
  next: Page.statCheck
  @next: {}

Page.StreetCatch.next['veryGood'] = Page.StreetCatchVeryGood = class StreetCatchVeryGood extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street.jpg"
    --
  """

Page.StreetCatch.next['good'] = Page.StreetCatchGood = class StreetCatchGood extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street.jpg"
    --
  """

Page.StreetCatch.next['bad'] = Page.StreetCatchBad = class StreetCatchBad extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street.jpg"
    --
  """

Page.StreetCatch.next['veryBad'] = Page.StreetCatchVeryBad = class StreetCatchVeryBad extends Page
  conditions:
    worker: {}
  text: ->"""|| bg="Sycamore/Street.jpg"
    --
  """
