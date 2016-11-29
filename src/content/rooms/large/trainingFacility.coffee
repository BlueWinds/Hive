add class TrainingFacility extends RoomJob
  label: "Training Facility"
  size: 'large'
  conditions:
    '|events|Nudity': {}
  effects:
    depravity: -400
    men: -4
    women: -2
  text: ->"""There are lots of young girls around here who need to be trained for their masters and mistresses. I enjoy breaking people. Let's do this!"""

add class TrainingFacility extends Page
  text: -> """|| bg="TrainingFacility/Rec2"
    -- Dark Lady Inc. Turning this...
  || bg="TrainingFacility/76"
    -- ...into this.
    --> One week, two week and four month training courses available. Inquire within, and don't delay!
  """

Game::trainingProgress = new Collection

# name: [name, start, duration, training]

trainer = [Person.DarkLady, Person.Liana, Person.Domme, Person.Sadist, Person.Maid]

add class TrainingFacility extends Job
  label: "Training Facility"
  text: ->
    trainings = Math.round((Page.sumStat 'lust', @context, @context) / 10)
    chances = Page.statCheckChances('intelligence', @difficulty(), @context)
    p = for key, value of g.trainingProgress
      "<li>#{key}<br>
      Day #{g.day - value[1]} of #{value[2]}<br>
      Trained #{value[3]} times</li>"

    """
      New student: #{Math.round((chances.good + chances.veryGood) * 100)}%

      <ul>#{p.join('') or '<li>No students</li>'}</ul>
      #{trainings} training sessions daily
      (<span class="lust">1/10 Lust</span>)
    """
  people:
    trainer1:
      label: ->'Trainer'
      is: trainer
    trainer2:
      label: ->'Trainer'
      is: trainer
      optional: true
    trainer3:
      label: ->'Trainer'
      is: trainer
      optional: true
    trainer4:
      label: ->'Trainer'
      is: trainer
      optional: true
    trainer5:
      label: ->'Trainer'
      is: trainer
      optional: true
  stat: 'intelligence'
  difficulty: -> 50 + 25 * g.trainingProgress.objectLength
  next: Page.statCheck
  @next: {}
  type: 'boring'

names = ['Christina', 'Melissa', 'Lucia', 'Yvette', 'Elisa', 'Cora', 'Diana', 'Pearl', 'Kelli', 'Kerry', 'Eileen', 'Deborah', 'Latoya', 'Lillian', 'Naomi', 'Gwen', 'Lela', 'Kristen', 'Rachel', 'Terry', 'Yvonne', 'Melanie', 'Felicia', 'Tina', 'Billie', 'Becky', 'Bessie', 'Jody', 'Roxanne', 'Holly', 'Kayla', 'Genevieve', 'Julia', 'Tamara', 'Lydia', 'Myra', 'Faith', 'Miranda', 'Stacey', 'Hattie', 'Andrea', 'Barbara', 'Judith', 'Jenna', 'Laura', 'Tammy', 'Renee', 'Adrienne', 'Lindsay', 'Alice', 'Irene', 'Sonya', 'Rose', 'Blue']

Job.TrainingFacility.next['good'] = add class TrainingFacilityNew extends Page
  conditions:
    duration: fill: -> Math.choice [7, 14, 30]
    name: fill: ->
      name = Math.choice names
      while g.trainingProgress[name]
        name = Math.choice names
      return name
    trainer1: {}
    trainer2: {}
    trainer3: {}
    trainer4: {}
    trainer5: {}
  text: ->
    c = [
      """|| bg="TrainingFacility/Rec1"
        -- #{@name} was grinning and joking around with her boyfriend a few minutes ago when she signed the papers. Too late to back out now!"""
      """|| bg="TrainingFacility/Rec2"
        -- Don't worry, sweety. We won't train the rebellion out of you - that fiery spirit is what your mistress likes best!"""
      """|| bg="TrainingFacility/Rec3"
        -- #{@name}'s excited to be here, and only got wetter as I explained what she's in for over the next #{Math.round(@duration / 7)} weeks. What a perv."""
      """|| bg="TrainingFacility/Rec4"
        -- Hm. Looks like #{@name} can't sign the consent form. Guess we'll just have to take Sir's word that this is what she wants."""
    ]

    """|| class="jobStart" auto="1800"
        <h4>Training Facility - New student</h4>

      #{Math.choice c}
        <em>#{@name} will stay here for #{@duration} days</em>
    """
  apply: ->
    super()
    g.trainingProgress[@context.name] = [@context.name, g.day, @context.duration, 0]

Page.TrainingFacilityNew::next = Job.TrainingFacility.next['bad'] = add class TrainingFacilityDaily extends Page
  conditions:
    trainings: fill: ->
      Math.round((Page.sumStat 'lust', g.last.context, g.last.context) / 10)
  text: ->
    if $('page').length and (Math.random() < 0.5 or g.events.TrainingFacilityDaily?[0] is g.day) then return false
    c = [
      """|| bg="TrainingFacility/11"
      || bg="TrainingFacility/12"
      || bg="TrainingFacility/13"
      || bg="TrainingFacility/13"
        -- Look at the way that angry flush turns into a blush turns into an orgasm. The clittoral vibrator turns higher the more people look at her."""
      """|| bg="TrainingFacility/2"
        -- Bowing her head submissively at the feet of whoever fills her with cum. #{Math.keyChoice g.trainingProgress}'s almost done with her training now!"""
      """|| bg="TrainingFacility/3"
        -- It's equally important for sluts in training to learn how to <em>not</em> be the center of attention. Being fucked in a line like this is an excellent reminder that sometimes, Sir doesn't care about them and just wants a piece of meat for his friends to share. It'll also be good practice for any of them who graduate from school into a brothel, rather than into the exclusive service of someone special."""
      """|| bg="TrainingFacility/4"
        -- Field trip day! All the girls get to wear clothes (a rare treat) and go into the outer world for a bit. It's all part of their training, of course - #{Math.keyChoice g.trainingProgress} isn't allowed to wipe the cum off their faces, and must offer to suck off anyone who asks about it."""
      """|| bg="TrainingFacility/5"
        -- #{Math.keyChoice g.trainingProgress} complained about the size of her butt plug this morning. The bruise will remind her for a few days that Mistress does <em>not</em> tollerate complaining."""
      """|| bg="TrainingFacility/6"
        -- Hestitate and blush all you like, honey, you're going to follow the leash eventually. She'll only make your walk outside longer the more you delay."""
      """|| bg="TrainingFacility/71"
      || bg="TrainingFacility/72"
      || bg="TrainingFacility/73"
      || bg="TrainingFacility/74"
      || bg="TrainingFacility/75"
      || bg="TrainingFacility/76"
      || bg="TrainingFacility/76"
        --"""
    ]

    """|| class="jobStart" auto="1800"
        <h4>Training Facility</h4>

      #{Math.choice c}
        <em>Divided #{@trainings} training sessions among #{g.trainingProgress.objectLength} students</em>
    """
  apply: ->
    super()
    total = @context.trainings
    while total > 0
      thisTraining = Math.ceil(total / 3)
      total -= thisTraining
      student = Math.keyChoice(g.trainingProgress)
      g.trainingProgress[student][3] += thisTraining

Page.TrainingFacilityDaily::next = add class TrainingFacilityGraduate extends Page
  conditions:
    student:
      fill: ->
        for name, student of g.trainingProgress
          if g.day >= student[1] + student[2] then return student
        return []
    depravity:
      fill: -> Math.round(Math.log(@student[3]) * 20) or 0
  text: ->
    unless @student[0] then return
    c = [
      """|| bg="TrainingFacility/Grad1"
        -- Today, #{@student[0]} has left our school. We wish her well in the wider world, and have given her a little gift to remember us by."""
      """|| bg="TrainingFacility/Grad2"
        -- #{@student[0]} has her final test today. Her Mistress will be by in a few hours to evaluate her progress - I hope she's pleased. #{@student[0]} certainly has no complaints about her new life."""
      """|| bg="TrainingFacility/Grad3"
        -- Like all the other students here, #{@student[0]} was enrolled by her partner. In this case, however, he hasn't been able to come up with the remainder of the fee, so #{@student[0]} will be auctioned off to cover it."""
    ]

    """|| class="jobStart" auto="1800"
        <h4>Training Facility - Graduation</h4>

      #{Math.choice c}
        <em>#{@student[0]} was here for #{g.day - @student[1]} days. She was trained #{@student[2]} times, and brings in <span class="depravity">#{@depravity}</span></em>
    """
  effects:
    depravity: 'depravity'
  apply: ->
    super()
    delete g.trainingProgress[@context.student[0]]
