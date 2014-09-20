LEGALCHARS = new RegExp(/[a-z0-9\s\-.?!]/)

@Table = new Meteor.Collection(null)
@IconWriter = new Meteor.Collection(null)

@table = {}
@table['rows'] = []
row1 = {}
row1['letters'] = ['a', 'b', 'c', 'd']
row2 = {}
row2['letters'] = ['d', 'c', 'b', 'a']
@table['rows'].push row1, row2

IconWriter.insert({iPhoneDisplay: true})

Template.home.rendered = () ->

  Table.insert(table)
  $('.writing-area').hide()




Template.home.events
  "keydown .writing-box, click .submit": (event, ui) ->
    if event.keyCode == 13 || event.keyCode == undefined
      $('.submit').css
        backgroundColor: 'white'
      $('.submit').animate
        backgroundColor: 'black',
        1000
      event.preventDefault()
      event.stopPropagation()
      text = $('.writing-box')[0].value.toLowerCase()
      generateTable(text)
      false
    else if event.keyCode != 13
      true
    else
      event.preventDefault()
      event.stopPropagation()
      false

  "click .essay": (event, ui) ->
    iPhoneDisplay = IconWriterFind('iPhoneDisplay')
    IconWriterUpdate({iPhoneDisplay: !iPhoneDisplay})
    unless IconWriterFind('iPhoneDisplay')
      text = $('.writing-box')[0].value.toLowerCase()
      generateTable(text)

  "click .legend": (event, ui) ->
    $('.legend-container').show()
    if $('.legend-container').hasClass('fadeIn')
      $('.legend-container').removeClass('fadeIn')
      $('.legend-container').addClass('fadeOut')
    else
      $('.legend-container').removeClass('fadeOut')
      $('.legend-container').addClass('fadeIn')

  "focus .btn": (event, ui) ->
    $('.btn').blur()



Template.home.helpers

  table: ->
    console.log Table.findOne({})
    Table.findOne({})

  iPhoneAnimate: ->
    if IconWriterFind('iPhoneDisplay') && $('.iphone-container').hasClass('fadeOut')
      'fadeIn'
    else if IconWriterFind('iPhoneDisplay') && !$('.iphone-container').hasClass('fadeOut')
      ''
    else
      'fadeOut'

  essayAnimate: ->
    if !IconWriterFind('iPhoneDisplay')
      $('.writing-area').show()
      'fadeIn'
    else
      'fadeOut'


@generateTable = (text) ->
  rows = []
  text = text.split('')
  if IconWriterFind('iPhoneDisplay')
    maxRows = 5
  else
    maxRows = 75
  while text.length > 0 && rows.length < maxRows
    rows.push {}
    rows[rows.length - 1]['letters'] = []
    for [0..3]
      console.log text
      console.log "Text[0] is: " + text[0]
      while text[0] && !text[0].match(LEGALCHARS)
        console.log 'illegal char'
        text = text.slice(1)
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
  else if test(text, '.') then '-'
  else if test(text, '!') then '!'
  else if test(text, 'dragon') then 'dragon'
  else if test(text, 'epi') then 'epi'
  else if test(text, 'netflix') then 'netflix'
  else if test(text, 'paypal') then 'paypal'
  else if test(text, 'snapguide') then 'snapguide'
  else if test(text, 'ted') then 'ted'
  else if test(text, 'vision') then 'vision'
  else if test(text, 'oo') then 'oo'
  else if test(text, 'ok') then 'ok'
  else if test(text, 'heart') then 'heart'
  else if test(text, 'dd') then "dd"
  else if test(text, 'whatsapp') then 'whatsapp'
  else if test(text, 'tweet') then 'tweet'
  else false

test = (text, query) ->
  if text[0..(query.length - 1)] + '' == query.split('') + ''
    query
  else false

specialCase = (text, result, rows) ->
  console.log 'special'
  rows[rows.length - 1]['letters'].push(result)
  text.slice(result.length)


@IconWriterUpdate = (objects) ->
  IconWriter.update({}, {$set: objects})

@IconWriterFind = (field) ->
  IconWriter.findOne()[field]


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
    when '2' then 'AmateurSurgeon'
    when '3' then 'Threes'
    when '4' then '4shared'
    when '5' then 'Five-O Deluxe'
    when '6' then '6 Numbers'
    when '7' then 'Sevens'
    when '8' then '8mm Camera'
    when '9' then '9GAG'
    when '_' then 'Yo'
    when '^' then 'Mystery Box'
    when '-' then 'Onavo Extend'
    when '!' then '!'
    when 'in' then 'LinkedIn'
    when 'dragon' then 'Dragon'
    when 'epi' then 'Epicurious'
    when 'netflix' then 'Netflix'
    when 'paypal' then 'Paypal'
    when 'snapguide' then 'Snapguide'
    when 'ted' then 'TED'
    when 'vision' then 'Vision Test'
    when 'oo' then 'OO Phone'
    when 'ok' then 'Keep it Local'
    when 'heart' then 'We Heart Pics'
    when 'dd' then "Dunkin' Donuts"
    when 'whatsapp' then 'WhatsApp'
    when 'tweet' then 'Twitter'
    else 'MissingNo'
)

