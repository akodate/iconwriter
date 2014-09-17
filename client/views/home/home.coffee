@Table = new Meteor.Collection(null)

@table = {}
@table['rows'] = []
row1 = {}
row1['letters'] = ['a', 'b', 'c', 'd']
row2 = {}
row2['letters'] = ['d', 'c', 'b', 'a']
@table['rows'].push row1, row2

Table.insert(@table)





Template.home.events
  "keydown .writing-box": (event, ui) ->
    if (event.keyCode == 13)
      event.preventDefault()
      event.stopPropagation()
      console.log "Submitted."
      text = $('.writing-box')[0].value
      console.log text
      generateTable(text)
      false
    else if event.keyCode != 13
      true
    else
      event.preventDefault()
      event.stopPropagation()
      false





Template.home.helpers

  table: ->
    console.log Table.findOne({})
    Table.findOne({})

@generateTable = (text) ->
  rows = []
  text = text.split('')
  while text.length > 0 && rows.length < 5
    rows.push {}
    rows[rows.length - 1]['letters'] = []
    for [0..3]
      if text.length > 0
        if result = isSpecialCase(text)
          console.log 'special'
          text = specialCase(text, result, rows)
        else
          console.log 'not special'
          rows[rows.length - 1]['letters'].push(text[0])
          text = text.slice(1)
  Table.update({}, {rows})

isSpecialCase = (text) ->
  if test(text, 'in') then 'in'
  else if test(text, ' ') then '_'
  else if test(text, '?') then '^'
  else if test(text, '...') then '---'
  else false

test = (text, query) ->
  if text[0..(query.length - 1)] + '' == query.split('') + ''
    query
  else false

specialCase = (text, result, rows) ->
  console.log 'special'
  rows[rows.length - 1]['letters'].push(result)
  text.slice(result.length)



Handlebars.registerHelper('title', (appName) ->
  switch appName
    when 'a' then 'Adobe Reader'
    when 'b' then 'Booking.com'
    when 'c' then 'Concur'
    when 'd' then 'Documents 5'
    when 'e' then 'Elevate'
    when 'f' then 'Facebook'
    when 'g' then 'Google Search'
    when 'h' then 'Hotels.com'
    when 'i' then 'Podcasts'
    when 'j' then 'Jackthreads'
    when 'k' then 'KAYAK'
    when 'l' then 'Letris 4'
    when 'm' then 'Monster.com'
    when 'n' then 'Nook'
    when 'o' then 'Opera'
    when 'p' then 'Pinterest'
    when 'q' then 'Quora'
    when 'r' then 'Runes 2'
    when 's' then 'Skype'
    when 't' then 'Tumblr'
    when 'u' then 'Uber'
    when 'v' then 'Vine'
    when 'w' then 'Words'
    when 'x' then 'Xtreme Wheels'
    when 'y' then 'Yocto Alarm'
    when 'z' then 'ZombieHighway'
    when '0' then 'White Zero'
    when '1' then '123 Ninja'
    when '2' then 'Amateur Surgeon'
    when '3' then 'Threes'
    when '4' then '4shared'
    when '5' then 'Five-O Deluxe'
    when '6' then '6 Numbers'
    when '7' then 'Sevens'
    when '8' then '8mm Camera'
    when '9' then '9GAG'
    when '_' then 'Yo'
    when '^' then 'Mystery Box'
    when '---' then 'Onavo Extend'
    when 'in' then 'LinkedIn'
    else 'Google Maps'
)

