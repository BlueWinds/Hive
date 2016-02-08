effect = ->
  e = 2
  if g.events.InWall then e += 1
  return e

cumEffect = (w)->
  if g.events.GaleriaPublicUse then Math.round(w.lust / 10) else 0

trainingCost = (w)->
  w.lust * (if g.events.GalleriaVisitors then 0.5 else 1)

add class Galleria extends RoomJob
  label: "Galleria"
  size: 'large'
  effects:
    depravity: -220
    women: -7
    men: -2
  text: ->"""Women get used as sex objects, men get to have their way with sex objects. Either way, they can increase their <span class="lust">lust</span> here."""

add class Galleria extends Page
  text: -> """|| bg="Galleria/3"
    -- `D Sluts, atteeeeen-tion!`
    --> `D Saaaaaal-ute!`
  || bg="Galleria/1"
    --> `D Very good girls, as you were.`
  """

add class Galleria extends Job
  label: "Galleria"
  text: ->"""18 hours :ahem: using the facilities should help remind them why we do what we do..

  <span class="lust">+#{effect()} Lust</span>, <span class="depravity">#{if g.events.GalleriaVisitors then '-0.5' else '-1'}</span> per current <span class="lust">lust</span>."""
  people:
    worker: matches: (w)-> g.depravity >= trainingCost(w) and w.lust < w.max.lust
  type: 'boring'

Job.Galleria::next = add class GalleriaDaily extends Page
  conditions:
    worker: {}
  text: ->
    if $('page').length and (Math.random() < 0.75 or g.events.GalleriaDaily?[0] is g.day) then return false
    c = [
      """|| bg="Galleria/1"
        -- Just because it's mostly women, doesn't mean I haven't scattered a few men in here to satisfy other tastes.""",
      """|| bg="Galleria/2"
        -- There's a wide selection to suit a variety of tastes. Brown, black, redhead... hm. I guess they are all skinny young bitches. Oh well, I work with what I'm given."""
      """|| bg="Galleria/3"
        -- Resting after a hard day's work. They may be slaves, but they're treated well."""
    ]
    if g.events.GalleriaVisitors
      c.push """|| bg="Galleria/Visitors1"
        -- Today's special - half off if you can make her cum and scream at the same time!"""
      c.push """|| bg="Galleria/Visitors2"
        -- Visitors tend to be a bit rougher on the girls than my own servants. I'm not really sure why that is. Oh well, they'll survive.""",
    if g.events.InWall
      c.push """|| bg="Galleria/Wall1.1"
        -- "Nice day out today, isn't it?"
        --> "Um... a bit lewd to talk about the weather while you're wiping the spunk off my asshole, isn't it?"
      || bg="Galleria/Wall1.2"
        --> "Oh, I suppose so. Just trying to be friendly. Sorry, I'll come around this side first next time."
      """
      c.push """|| bg="Galleria/Wall2"
        -- It is a less than dignified position, and even the fact that they only have to work half-days when they're in the wall doesn't make up for it for many of them."""
      c.push """|| bg="Galleria/Wall3"
        -- Cunts on display, cunts for use. They belong to women, but who cares?"""
      c.push """|| bg="Galleria/Wall4"
        -- Sometimes it's nice to leave the legs free - they can squirm and react more effectively that way."""
    if g.events.GaleriaPublicUse
      c.push """|| bg="Galleria/Use1"
        -- I publish daily rankings based on the size of the pool of cum at each of their feet. Competition is fierce."""
      c.push """|| bg="Galleria/Use2"
        -- Such a sad face. It's ok little lady, they still enjoyed it even if you didn't get to swallow."""
      c.push """|| bg="Galleria/Use3"
        -- Some women enjoy being used like a fuckdoll more than might be strictly called "healthy"."""

    """|| class="jobStart" auto="1800"
        <h4>Galleria</h4>

      #{Math.choice c}
        <em><span class="lust">+#{effect()} Lust</span>, <span class="depravity">-#{trainingCost @worker}</span></em>
    """
  apply: ->
    super()
    @context.worker.add 'lust', effect()
    g.applyEffects {
      depravity: -trainingCost(@context.worker)
      cum: cumEffect(@context.worker)
    }

add class GalleriaVisitors extends ResearchJob
  conditions:
    '|events|Galleria': {}
  label: "Galleria Visitors"
  progress: 600
  text: ->"""<span class="depravity">-50% </span> cost when visiting the galleria.
  <br>Hmm. It seems like the girls could use more work. Let's invite people from the town to pay them a visit."""

add class GalleriaVisitors extends Page
  text: ->"""|| bg="Galleria/5"
    -- Amber (who called herself Skye)
      Spread her thighs, as she said with a sigh:
      "I've shaved myself bare
      to get more flow of air,
      else my panties just never stay dry."
  """

add class InWall extends ResearchJob
  conditions:
    '|events|GalleriaVisitors': {}
  label: "Through the wall"
  progress: 500
  text: ->"""<span class="lust">+1 Lust</span> when visiting the galleria.
  <br>If you lock them in, they can't squirm around and avoid your attentions. Fun."""

add class InWall extends Page
  text: ->"""|| bg="Galleria/6"
    -- On the breast of the whore named Gail.
      Was tattooed the price of her tail.
      And on her behind,
      For the sake of the blind,
      Was the same information in Braille.
  """

add class GaleriaPublicUse extends ResearchJob
  conditions:
    '|events|MoreResources': {}
    '|events|GalleriaVisitors': {}
  label: "Public Use"
  progress: 250
  text: ->"""Vists to the Galeria generate <span class="lust">Lust / 10</span> <span class="cum"></span>.
    <br>Tie 'em up, fuck 'em, get out of the way, let's keep the line moving."""

add class GaleriaPublicUse extends Page
  text: ->"""|| bg="Galleria/Use3"
    -- A luscious psychotic named Jane
      Sucked every man on a train.
      She said, "Please don't panic,
      I'm just nymphomanic,
      This wouldn't be fun were I sane."
  """
