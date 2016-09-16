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

stillResearch = ->
  for k, v of g.map.Research.jobs when v then return true
  return g.goal?

add class Laboratory extends Job
  label: "Laboratory"
  text: -> """It's not just a matter of sticking things in new orifices - I need to make sure my slaves are happy and healthy with each new perversion I bless them with. A researcher here can help me figure out how, with their <span class="intelligence">Intelligence</span> and <span class="magic">Magic</span>.
  <br><span class="depravity">-#{progress @context.researcher}</span>, +#{progress(@context.researcher) * 2} progress</em>
  <em>#{g.goal?.label or ''}</em>
  #{(g.goal?.constructor::progress - g.goal?.progress) or 0}/#{g.goal?.constructor::progress or 0}"""
  people:
    researcher:
      matches: stillResearch
      label: -> if stillResearch() then '' else 'No more topics'
  next: Page.ResearchChoice

progress = Page.Laboratory.researchProgress = (researcher)->
  unless researcher then return 0
  Math.min(g.depravity, Math.floor(researcher.intelligence * 0.5 + researcher.magic * 0.25))
