Page.LeaveEmpty = class LeaveEmpty extends Page
  text: -> false

Job.SmallRoom = class SmallRoom extends Job
  officers:
    'Dark Lady': '|officers|DarkLady'
  type: 'special'
  label: "Empty Room"
  text: ->"""A bedroom at Holiday Inn. I can turn it into something more useful."""
  size: 'small'
  next: Page.EmptyRoom

Place.Rooms::jobs.leaveEmpty = RoomJob.LeaveEmpty = class LeaveEmpty extends RoomJob
  label: "Leave Empty"
  text: ->"""Peeling paint. I like peeling paint. Pick some of it off the wall, flick it on the floor, leave everything alone."""
  room: false
  size: 'small'
  effects: {}
  next: Page.LeaveEmpty

Job.MediumRoom = class MediumRoom extends Job
  officers:
    'Dark Lady': '|officers|DarkLady'
  type: 'special'
  label: "Empty Space"
  text: ->"""An empty suite, garage or officespace. I can turn it into something more useful."""
  size: 'medium'
  next: Page.EmptyRoom

Place.Rooms::jobs.leaveEmptyMed = RoomJob.LeaveEmptyMed = class LeaveEmptyMed extends RoomJob.LeaveEmpty
  text: ->"""Uninspiring. I'm not feeling the urge to do anything at all with this space right now."""
  size: 'medium'
