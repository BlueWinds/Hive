add class NorthEnd extends Place
  name: 'North End'
  description: 'I have a "zoning permit" for this area. Time to do whatever the fuck I want.'
  image: 'Council/NorthEnd'
  jobs: new Collection
    Fire: Job.Fire
    1: Job.LargeRoom
    2: Job.LargeRoom
    3: Job.LargeRoom
  location: [483, 80]
  destinations: new Collection

add class ProfessorsOrdeal extends Job
  place: 'NorthEnd'
  conditions:
    '|events': matches: (e)->
      return not e.ProfessorsOrdeal or e.ProfessorsOrdeal.length < 2 or e.ProfessorsOrdeal[0] < (g.day - 4)
  people:
    Liana: '|people|Liana'
  type: 'plot'
  label: "Professor's Ordeal"
  text: ->"""Hm, I made Liana a promise, didn't I? Time to keep one part of it."""
  next: Page.firstNew
  @next: []

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal1 extends Page
  text: ->"""|| bg="Liana/Happy"
  -- `L I found her.`
  --> `D Found who?`
  --> `L My economics professor. She flunked me. She's part of the reason I summoned you to get revenge. I saw her in the slave pens.`
  --> `D I thought you summoned me because you were my loyal servant.`

  -- `L Um... yes, that too mistress. But you promised me I could have everyone from the university to do with as I see fit.`
  --> `D ...`
  --> `L ...`
  --> `D ...`

  -- `L Oh, um... yeah, I guess I did say I just wanted the dean's office. But may I have her anyway, mistress?`
  --> I have no idea what a Dean is, but she asked so cutely I can't help but agree. Well, that may be the wrong term for the sadistic gleam in her eye... but "cute" is my story and I'm sticking to it.
  --> `D Very well.`
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal2 extends Page
  text: ->"""|| bg="Liana/Happy"
    -- Dear diary.
    --> Today I met someone I knew: a former student of mine. She took me out of that horrid place, gave me a room of my own and most of my things back. Except my clothes. I'm still naked, as I've been ever since I followed that guy back to his room more than a week ago. God, why didn't I listen to that little voice saying not to? Well, anyway, moot point now. One leg chained to a pipe, I'm otherwise free to move around. I think they did something to my head - I feel like I should be trying to escape, but really, it's not bothering me too much.

    --> Anyway, back to that student. I recognized her face, but when she asked if I knew her name, I came up blank. I'm pretty sure, in retrospect, that was a terrible mistake. I think she's important around here, and I think I made her angry. What can you do? I'll just have to see what she wants and try to make it up to her and convince her to let me go.
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal3 extends Page
  text: ->"""||
    -- Dear diary.
    --> Today has been the worst day of my life, though I'm sure tomorrow will be worse. That student of mine is apparently a mage. Who knew magic was real?
  || bg="Council/Professor1"
    --> I'm no longer in my oh-so-comfortable room - as I write, I'm huddling under the bridge she chained me to. I've got nothing to my name except this diary, a pen, a sheet of prices, and a box to lock them in. The sheet of prices is the worst thing.

    --| <table class="table table-striped"><tr><td>$10</td><td>500ml cum (fresh!)</td></tr><tr><td>$50</td><td>Bottled water</td></tr><tr><td>$50</td><td>New pen and additional paper</td></tr><tr><td>$120</td><td>Loaf of bread</td></tr><tr><td>$800</td><td>Panties</td></tr><tr><td>$1000</td><td>One night inside</td></tr><tr><td>$15000</td><td>One letter of her name</td></tr></table>

    Etc. I've skipped a bunch. It goes on.

    --> Apparently I'm to be chained up here until I can tell her her name. Where the fuck am I supposed to get money, chained to the underside of a bridge?
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal4 extends Page
  text: ->"""|| bg="Council/Professor1"
    -- Dear diary.
    --> Today I sucked a cock for $20. How humiliating. But... I'm really thirsty. $20 isn't much, but it's better than nothing. Would she really let me die, if I refused to humiliate myself like this? I don't know, and honestly, I'm kind of scared to find out. Who knew we had such students at our school? I guess it only goes to show that there's a bit of demon in all of us... Oh, wait, I have to go. It looks like that guy is back, and he brought friends. Horrible as it may be, I need the money.

    --> Wow, that was disgusting. I've now sucked more cocks today than I have in the rest of my life put together. My boyfriends always wanted me to, but I never really like the taste. At least I have enough money now to afford some scanty meals and a bottle of water when she comes to check up on me in a few hours.
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal5 extends Page
  text: ->"""|| bg="Council/Professor2"
    -- Dear diary.
    --> Today has been a very, very bad day. I guess there's some sort of big event? Anyway, I saw hardly anyone at all, and they were all busy. I only managed to earn $40 today. Combined with the $30 I have left from yesterday... it's not enough for food. Shit. I'm hungry though, so... oh god, I can't belive I'm acutally going to order cum for food. I miss my old life. But you do what you have to.

    --> I've also given up hope of rescue. It seems like there's a spell around me - I don't know what's wrong with these people, but no one seems to care if I ask for help. I think I'm going to be stuck here until I can buy my way out. Fuck. $15000 per letter of her name? I don't even know how long it is! I'm going to be here for a while.
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal6 extends Page
  text: ->"""|| bg="Council/Professor2"
    -- Dear diary.
    --> It was too disgusting the first time I tried, but after thinking on it a few days... I've given up on buying food. If I subsist on nothing but cum - I've found I need around two purchases per day, supplemented with a few nibbles from bread I saved here and there - I can save up money so much faster.

  || bg="Council/Professor3"
    --> I had my first gangbang today. Four guys, $120 each... I'm such a slut. But they really did take good care of me - both breasts getting sucked on, while the one hung like a horse reamed my cunt? My god it felt good. And with that much money... I'm around 5% of the way to buying the first letter of her name. Fuck it's depressing to calculate out like that. Oh well.
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal7 extends Page
  text: ->"""|| bg="Council/Professor2"
    -- Dear diary.
    --> I had to buy more paper today, since I was careless and left my sign out yesterday when it rained. So, first some good news. I'm completely used to being nude now! It doesn't bother me at all anymore, and in fact I sort of forget, now and then, that I used to wear clothes all the time. I was reminded because I got female customer - she had me eat her out, and her panties were so cute. When I first got here, all I thought about was buying some of those for myself, but now I see there's no point in wasting the money.
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal8 extends Page
  text: ->"""|| bg="Council/Professor3"
    -- Dear diary.
    --> I had quite a line today! Seems that word has spread about the naked woman under the bridge who'll do anything you ask. I heard some people muttering about the prices - apparently there are more prostitutes in town than I'd thought - so I lowered my prices yesterday to make sure everyone keeps coming back. Today I ended up taking everyone double - front door and ass - just to keep up with demand.

  || bg="Council/Professor2"
    --> I'm so sore, and really tired, but with $15000... tomorrow I'll be able to afford the first letter of her name. Maybe one letter will be enough to jog my memory?
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal9 extends Page
  text: ->"""|| bg="Council/Professor3"
    -- Dear diary.
    --> Today was amazing. This one woman wanted to try fisting my ass, and I had to add a new line to my price sheet for her, but it felt great. I think I'll make it cheeper, see if I can't get more people to try that.

  || bg="Council/Professor1"
    --> Anyway, I'm making enough money now that I could easily switch back to real food, but what's the point? Semen tastes really nice, and I love the looks people give me when they see me drinking it. I'll have enough to buy a second letter soon. "L..." still don't remember her name. Oh well.
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal10 extends Page
  text: ->"""|| bg="Council/Professor2"
    -- Dear diary.
    --> I bought the third letter today. "Lia..." I wracked my brains, but really, I'm just going to have to buy the whole thing. Anyway, I'm not sure why I was so desperate to get out originally? I mean, yeah, it'd be kind of nice to have some change of scenery - it'd probably be fun to fuck up by the side of the road, rather than under the bridge. I'd probably get more business too, if more people saw me.
  """

Job.ProfessorsOrdeal.next.push add class ProfessorsOrdeal11 extends Page
  text: ->"""|| bg="Council/Professor2"
    -- Dear diary.
    --> I bought the last letter in her name two days ago - Liana - but honestly, I'm not really sure why at this point. I guess I flunked her out of my class? I guess I did used to teach classes or something. She undid my chains, which is pretty nice, but I'm glad she agreed to keep coming by every day to take some money and bring me bottles of cum.

  || bg="Council/Professor3"
    --> Anyway, this will be my last entry. I'm running out of paper, and don't see why I should bother to get more. It's been fun reading back through my earlier entries - god, I used to be such a prude! Time to go, though. I see one of my regulars coming, and promised him something extra special for his complimentary 100th visit.
  """
  effects:
    remove:
      '|map|NorthEnd|jobs|ProfessorsOrdeal': Job.ProfessorsOrdeal

add class TentacleRaid extends Job
  place: 'NorthEnd'
  conditions:
    '|events|BreedingPitDaily': {}
    '|depravity':
      gte: 100
  people:
    'Dark Lady': '|people|DarkLady'
    'Goon 1': {optional: true}
    'Goon 2': {optional: true}
  label: "Hunting"
  text: ->"""A dose of nighttime terrors would do this sleepy little town some good (by convincing them not to oppose me). Also, it would be good preparation for taking over completely, which is a thing I've put off for far too long now.

  <span class='depravity'>-50</span>, <span class="resistance">-5</span>"""
  next: Page.TentacleRaid

add class TentacleRaid extends Page
  text: ->
    c = [
      """|| bg="NorthEnd/Raid11"
        || bg="NorthEnd/Raid12"
        || bg="NorthEnd/Raid13"
        || bg="NorthEnd/Raid14"
        || bg="NorthEnd/Raid15"
        || bg="NorthEnd/Raid16"
        || bg="NorthEnd/Raid16"
        -- It may look like she has it easier than most girls violated by tentacles, but I assure you, the "spin + egg injection" setting is no joke. She'll soon be the proud mother of the next generation of horrors.""",
      """|| bg="NorthEnd/Raid2"
        -- She can cling as much as she likes now, but this breed is patient. Eventually she'll relax and it can swallow her to act as the new incubation core.""",
      """|| bg="NorthEnd/Raid31"
        || bg="NorthEnd/Raid32"
        || bg="NorthEnd/Raid32"
        || bg="NorthEnd/Raid32"
        -- Pretty sure she genuinely enjoyed this. Some girls are just fucked in the head, I guess. Unlike most of the brood mothers, I'll let her go to carry out her term at home.""",
      """|| bg="NorthEnd/Raid41"
        || bg="NorthEnd/Raid42"
        || bg="NorthEnd/Raid43"
        || bg="NorthEnd/Raid44"
        || bg="NorthEnd/Raid45"
        || bg="NorthEnd/Raid45"
        -- Once she stops struggling I'll let her arms and legs loose. The living vat of goo will be her home for the next four months while it reproduces.""",
      """|| bg="NorthEnd/Raid5"
        -- The joys of motherhood. Doesn't she just glow with good health?""",
    ]

    """#{Math.choice c}
    <span class='depravity'>-50</span>, <span class="resistance">-5</span>"""
  effects:
    depravity: -50
    resistance: -5
