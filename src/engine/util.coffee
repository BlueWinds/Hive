
String.rate = (number)-> switch number
  when 1 / 4 then 'a quarter'
  when 1 / 3 then 'a third'
  when 1 / 2 then 'half'
  when 2 / 3 then 'two thirds'
  when 1 then ''
  when 2 then 'twice'
  when 3 then 'three times'
  else number.toString()

Object.defineProperty Number.prototype, 'toWord', { value: ->
  return {
    0: 'zero'
    1: 'one'
    2: 'two'
    3: 'three'
    4: 'four'
    5: 'five'
    6: 'six'
    7: 'seven'
    8: 'eight'
    9: 'nine'
    10: 'ten'
    11: 'eleven'
  }[@] or Number(@).toString()
}

Object.defineProperty Number.prototype, 'rounded', { value: ->
  return Number(@).toFixed(1).replace(".0", "")
}

Object.defineProperty String.prototype, 'capitalize', { value: ->
  @charAt(0).toUpperCase() + @slice(1)
}

Object.defineProperty Array.prototype, 'wordJoin', {value: ->
  str = @slice(0, -1).join(', ')
  str += ' and ' + @[@length - 1]
  return str
}

Math.sum = (items)->
  sum = 0
  for val in items
    sum += val
  return sum

Math.sumObject = (items)->
  sum = 0
  for key, val of items
    sum += val
  return sum

Math.randomRound = (number)->
  result = Math.floor(number)
  if Math.random() < number % 1 then result += 1
  return result

Math.keyChoice = (items)->
  if items instanceof Array
    choice = Math.floor(Math.random() * items.length)
    return choice
  return Math.choice(Object.keys items)

Math.choice = (items)->
  return items[Math.keyChoice items]

Math.otherChoice = (items, last)->
  choice = Math.choice items
  while choice is last
    choice = Math.choice items
  return choice

Math.weightedChoice = (weights)->
  sum = Math.sumObject weights
  choice = Math.floor(Math.random() * sum)
  for key, value of weights
    choice -= value
    if choice <= 0 then return key

String.randomName = (names, maxLength = 7)->
  [chains, start] = String.randomName.chains(names)

  string = Math.choice(start).split('')

  newLetter = ->
    last = string[string.length - 3] + string[string.length - 2] + string[string.length - 1]
    next = Math.choice(chains[last])
    return next

  while string[string.length - 1] and string.length <= maxLength
    string.push(newLetter())

  string.pop()
  string[0] = string[0].toUpperCase()
  return string.join('')

String.randomName.chains = (names)->
  # Building the Markov chains
  chains = {}
  start = []

  names.forEach (name)->
    start.push(name.substr(0, 3).toLowerCase())
    for i in [0 .. name.length - 3]
      token = name.substr(i, 3).toLowerCase()
      next = name[i + 3]
      chains[token] or= []
      chains[token].push(next?.toLowerCase())

  return [chains, start]

###
Formatting guide:

  New <page>
    || attr="val"
    <div>Tags will be appended to the page, until a text starts</div>

  Start new <text>
    -- Can be followed by contents
    Each new line after this starts a new paragraph.
    <button>Any line that starts with a tag won't be wrapped in a paragraph.</button>
    `Natalie This text will be quoted in Natalie's colors`

    Extra new lines will be ignored.
    -- After a text has started in a page, any following texts will keep the current background / character art.

  Start full <text>
    --|

  Continue last <text>
    -->

  Quote text:
  `D quoted text` transforms to <q class="D">quoted text</q>
###

$.render = (element)->
  if not element or typeof element isnt 'string'
    return element or $('')

  pages = $('<div></div>')
  for line, index in lines = element.split("\n")
    line = line.trim().replace(/`([a-zA-Z]*) (.+?)`/g, "<q class='$1'>$2</q>")
    if line.match /^\|\|/
      pages.append page = $('<page></page>')
      addAttrs(page, line)
      addBackground(page, pages)
    else if line.match(/--/)
      textLine(line, pages)
    else if line
      page = pages.children().last()
      parent = if page.find('text').length then page.find('text') else page
      parent.append('<p>' + line + '</p>')

  return if pages.children().length then pages.children() else false

textLine = (line, pages)->
  page = pages.children().last()
  if page.find('text').length
    page = page.clone()
    page.find('text').remove()
    pages.append page

  text = if line.match(/^-->/)
    pages.find('text').last().clone()
  else if line.match(/^--\|/)
    $('<text class="full"></text>')
  else
    $('<text></text>')

  page.append(text)
  line = line.replace(/--\|?>?/, '')

  text.append('<p>' + line + '</p>')

addAttrs = (element, text)->
  for attr in text.match(/\w+=".+?"/g) or []
    match = attr.match(/(\w+)="(.+?)"/)
    element.attr(match[1], match[2])

addBackground = (element)->
  if element.attr 'bg'
    bg = 'url("game/images/' + element.attr('bg') + '.jpg")'
  else
    bg = element.prev().css('background-image')

  if bg and bg isnt 'none'
    element.css('background-image', bg)

window.toggle = (options, selected)->
  options = optionList options, selected
  return """<span class="btn-group toggle">#{options.join ''}</span>"""

window.bigOptions = (options, selected)->
  options = optionList options, selected
  join = '</div><div class="col-md-4 col-xs-6">'
  return """<div class="bigOptions row"><div class="col-md-4 col-xs-6">#{options.join join}</div></div>"""

window.dropdown = (options, selected)->
  lis = optionList options, selected
  return """<button type="button" class="btn btn-default dropdown-toggle inline">#{options[selected]}</button><span class="dropdown-menu inline"><span>#{lis.join '</span><span>'}</span></span>"""

window.options = (texts, titles = [])->
  buttons = for text, index in texts
    """<button class="btn btn-default" title="#{titles[index] or ""}">#{text}</button>"""
  return "<options>#{buttons.join("")}</options>"

optionList = (options, selected)->
  name = 'o-' + Math.random()
  options = for key, option of options
    _id = 'o-' + Math.random()
    checked = if selected is key then 'checked' else ''
    """<input type="radio" id="#{_id}" value="#{key}" #{checked} name="#{name}"><label for="#{_id}">#{option}</label>"""
  return options

###
  Based on dragScroll by James Climer. https://github.com/jaclimer/JQuery-DraggScroll
###
$.fn?.dragScroll = (bounds)->
  dragging = false
  $scrollArea = $(@)

  $scrollArea.on 'mousedown touchstart', (e)->
    e.preventDefault()
    dragging =
      x: e.pageX
      y: e.pageY
      top: $(@).scrollTop()
      left: $(@).scrollLeft()

  $("body").on 'mouseup mouseleave touchend touchcancel', -> dragging = false

  $("body").on 'mousemove touchmove', (e)->
    unless dragging then return
    $scrollArea.scrollLeft(Math.min(bounds.right, Math.max(bounds.left, dragging.left - e.pageX + dragging.x)))
    $scrollArea.scrollTop(Math.min(bounds.bottom, Math.max(bounds.top, dragging.top - e.pageY + dragging.y)))

Date.prototype.addDays = (days)->
  dat = new Date(@valueOf())
  dat.setDate(dat.getDate() + days)
  return dat
