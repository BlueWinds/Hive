add class Laboratory extends RoomJob
  label: "Laboratory"
  effects:
    depravity: -100
    virgins: -2
  size: 'medium'
  text: ->"""I can research upgrades to my various rooms here. It's embarrassing to consider how poorly run my current operation is."""

add class Laboratory extends Page
  text: -> """|| bg="Laboratory/1"
    -- A pair of sweet young research assistants. They're bright little things, perfectly aware of what this research entails, and not at all brainwashed. Who wouldn't want to spend their days dreaming up new perversions?
  """

add class Laboratory extends Job
  label: "Laboratory"
  text: -> """It's not just a matter of sticking things in new orifices - I need to make sure my slaves are happy and healthy with each new perversion I bless them with. A researcher here can help me figure out how.
  <br>Daily progress is <span class="intelligence">Intelligence</span> + <span class="magic">1/2 Magic</span>.
  <em><span class="depravity">-1/2</em> per point of progress</em>"""
  people:
    researcher: {}
  next: Page.ResearchChoice
