add class LeaveEmpty extends Page
  text: -> false

add class SmallRoom extends Job
  people:
    'Dark Lady': '|people|DarkLady'
  type: 'special'
  label: "Empty Room"
  text: ->"""A bedroom at Holiday Inn. I can turn it into something more useful."""
  size: 'small'
  next: Page.EmptyRoom

add class LeaveEmpty extends RoomJob
  label: "Leave Empty"
  text: ->"""Peeling paint. I like peeling paint. Pick some of it off the wall, flick it on the floor, leave everything alone."""
  room: false
  size: 'small'
  effects: {}
  next: Page.LeaveEmpty

add class MediumRoom extends Job
  people:
    'Dark Lady': '|people|DarkLady'
  type: 'special'
  label: "Empty Space"
  text: ->"""An empty suite, garage or office space. I can turn it into something more useful."""
  size: 'medium'
  next: Page.EmptyRoom

add class LeaveEmptyMed extends RoomJob.LeaveEmpty
  text: ->"""Uninspiring. I'm not feeling the urge to do anything at all with this space right now."""
  size: 'medium'

add class LargeRoom extends Job
  people:
    'Dark Lady': '|people|DarkLady'
  type: 'special'
  label: "Empty Lot"
  text: ->"""An empty square of land. Let's build something here.."""
  size: 'large'
  next: Page.EmptyRoom

add class LeaveEmptyLarge extends RoomJob.LeaveEmpty
  text: ->"""Too much work, and I like the pile of broken glass and newspaper in one corner. Leave it."""
  size: 'large'
