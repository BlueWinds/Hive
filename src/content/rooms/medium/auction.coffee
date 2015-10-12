add class AuctionHouse extends RoomJob
  label: "Auction House"
  size: 'medium'
  effects:
    depravity: -200
    women: -2
    men: -1
  text: ->"""Selling slaves is an ancient tradition of mine. In addition to being fucking sexy, a slave auction is a great way to raise fast capital for further expansion. Liana tells me slavery is illegal in the Oooessay (why does she wince every time I say her country's name?), so I'll have to modify the basic formula a bit, but still."""

add class AuctionHouse extends Page
  text: -> """|| bg="AuctionHouse/1.jpg"
    -- To avoid attracting the notice of anyone who might be inclined to object, I've warded the auction house with powerful spells. As soon as you leave, the memory fades to nothing more than a sexy dream - unless you've bought a slave, in which case you're in too deep to back out.
  """

basePrice =
  Sadist: 75
  Domme: 100
  Maid: 200
  'Sex Slave': 125
  'Sex Slave': 100
sellPrice = (p)->
  unless p then return 0
  Math.floor(basePrice[p] * (50 + p.strength + p.intelligence + p.lust + p.magic * 5) / 100)

add class AuctionHouse extends Job
  label: "Auction House"
  people:
    Dealer: is: [Person.DarkLady, Person.Liana, Person.Sadist, Person.Domme]
    Merchandise: isnt: [Person.DarkLady, Person.Liana]
  text: ->"""This isn't the sort of auction where low-grade human chattel is dealt with - exclusive merchandise, exclusive clientele. All the of the merchandise's stats contribute to the price.

  <em class="depravity">+#{sellPrice @context.Merchandise}</em>.

    #{Page.statCheckDescription('intelligence|lust', 65, Job.AuctionHouse.next, @context)}"""
  stat: 'intelligence|lust'
  difficulty: 65
  next: Page.statCheck
  @next: {}
  type: 'special'

Job.AuctionHouse.next['good'] = add class AuctionGood extends Page
  conditions:
    job: '|last'
    Merchandise: {}
    price: fill: -> sellPrice @Merchandise
  text: -> Math.choice([
    """|| bg="AuctionHouse/1.jpg"
      -- On her hands and knees, this shows off her charms for the customers, and they snapped her right up.""",
    """|| bg="AuctionHouse/2.jpg"
      -- All the slaves sold here are highly trained - the chains and gags are hardly necessary, but they do add a certain ambiance to the proceedings that I'd be loath to do without."""
    """|| bg="AuctionHouse/3.jpg"
      -- She displays her obedience for her new (potential) owner."""
    """|| bg="AuctionHouse/4.jpg"
      -- "And next up we have this wonderful slut and her sister. Own both in the bargain of the century. Shall we start the bidding at $25,000... $25,000 from the gentlemen up front. $30,000... yes, I have $30,000..." """
    """|| bg="AuctionHouse/5.jpg"
      -- "Yes she is, the cutest little slut you ever did see. Ladies and gentlemen, just look at how wet she is at the prospect of being owned by one of you. Shall I ask her to do anything else before we begin? Yes? Good idea sir, someone bring me a butt plug. Now, let's start the bidding at $20,000. Come on, don't be shy..." """
    ]) + "\n<em class='depravity'>+#{@price}</em>"
  apply: ->
    super()
    delete @context.job.context.Merchandise
    g.people.remove @context.Merchandise
  effects:
    depravity: 'price'

Job.AuctionHouse.next['bad'] = add class AuctionBad extends Page
  conditions:
    Merchandise: {}
  text: ->"""|| bg="AuctionHouse/6.jpg"
    -- The #{@Merchandise.name.toLowerCase()} didn't sell today - quite a shame, but no one was willing to shell out a fair price for the #{him}. Oh well, there's always tomorrow."""
