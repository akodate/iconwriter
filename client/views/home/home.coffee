LEGALCHARS = new RegExp(/[a-z0-9\s\_.?!+$]/)
THREETYPES = 'abgilmnoprst'
TWOTYPES = 'cdefhjqvwxy'
ONETYPE = 'kuz'

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

  width = getWidth()
  if width < 768
    if width < 480
      width = width - 10
    $('.iphone-container').css('margin-left', (width - 321) / 2 + 'px')
    $('.icon-table-container').css('margin-left', (width - 321) / 2 + 'px')




Template.home.events
  "keydown .writing-box, click .submit": (event, ui) ->
    if event.keyCode == 13 || event.keyCode == undefined
      $('.submit').css
        backgroundColor: 'white'
      $('.submit').animate
        backgroundColor: 'black',
        1500
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

    opts = {}
    opts.canvas = $("#canvas")[0]
    opts.image = $(".iphone")[0]
    drawImage opts
    return

    $('.legend-container').show()
    if $('.legend-container').hasClass('fadeIn')
      $('.legend-container').removeClass('fadeIn')
      $('.legend-container').addClass('fadeOut')
      Meteor.setTimeout (() ->
        $('.legend-container').hide()
      ), 500
    else
      $('.legend-container').removeClass('fadeOut')
      $('.legend-container').addClass('fadeIn')

  "focus .btn": (event, ui) ->
    $('.btn').blur()

  "click .legend-text": (event, ui) ->
    text = event.target.outerText
    $('.writing-box').val($('.writing-box').val() + text)



Template.home.helpers

  table: ->
    # console.log Table.findOne({})
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
      # console.log text
      # console.log "Text[0] is: " + text[0]
      while text[0] && !text[0].match(LEGALCHARS)
        # console.log 'illegal char'
        text = text.slice(1)
      if text.length > 0
        if result = isSpecialCase(text)
          # console.log 'special'
          text = specialCase(text, result, rows)
        else
          # console.log 'not special'
          rows[rows.length - 1]['letters'].push(text[0])
          text = text.slice(1)
  diversify(rows)
  Table.update({}, {rows})

@diversify = (rows) ->
  parse(rows, THREETYPES, 3)
  parse(rows, TWOTYPES, 2)

@parse = (rows, letterList, typeCount) ->
  for l in letterList
    counter = 0
    for row, index in rows
      if row.letters
        for icon, index2 in row.letters
          if l == icon
            if counter % typeCount != 0
              newIcon = icon + '_' + (counter % typeCount + 1)
              rows[index].letters[index2] = newIcon
            counter += 1



isSpecialCase = (text) ->
  if test(text, 'whatsapp') then 'whatsapp'
  else if test(text, 'tweet') then 'tweet'
  else if test(text, '2048') then '2048'
  else if test(text, 'angrybirds') then 'angrybirds'
  else if test(text, 'candycrush') then 'candycrush'
  else if test(text, 'clashofclans') then 'clashofclans'
  else if test(text, 'fruitninja') then 'fruitninja'
  else if test(text, 'instagram') then 'instagram'
  else if test(text, 'messenger') then 'messenger'
  else if test(text, 'minecraft') then 'minecraft'
  else if test(text, 'shazam') then 'shazam'
  else if test(text, 'snapchat') then 'snapchat'
  else if test(text, 'templerun') then 'templerun'
  else if test(text, 'youtube') then 'youtube'
  else if test(text, 'netflix') then 'netflix' # Popular
  else if test(text, 'vision') then 'vision'
  else if test(text, 'heart') then 'heart'
  else if test(text, 'airplane') then 'airplane'
  else if test(text, 'holybible') then 'holybible'
  else if test(text, 'creeper') then 'creeper'
  else if test(text, 'check') then 'check'
  else if test(text, 'scarykids') then 'scarykids'
  else if test(text, 'sunny') then 'sunny'
  else if test(text, 'starry') then 'starry'
  else if test(text, 'jpyen') then 'jpyen'
  else if test(text, 'fixit') then 'fixit'
  else if test(text, 'pressplay') then 'pressplay'
  else if test(text, 'musicnote') then 'musicnote'
  else if test(text, 'unimpressed') then 'unimpressed'
  else if test(text, 'interested') then 'interested'
  else if test(text, 'burger') then 'burger'
  else if test(text, 'book') then 'book'
  else if test(text, 'smile') then 'smile'
  else if test(text, 'joyous') then 'joyous'
  else if test(text, 'globe') then 'globe'
  else if test(text, 'asleep') then 'asleep'
  else if test(text, 'determined') then 'determined'
  else if test(text, 'hello') then 'hello'
  else if test(text, 'kitty') then 'kitty'
  else if test(text, 'quotes') then 'quotes'
  else if test(text, '42') then '42'  # Expressive
  else if test(text, '!?') then '!?'
  else if test(text, ' ') then '_'
  else if test(text, '?') then '^'
  else if test(text, '.') then '-'
  else if test(text, '!') then '!'
  else if test(text, '+') then '+'
  else if test(text, '$') then '$' # Symbols
  else if test(text, 'dragon') then 'dragon'
  else if test(text, 'yelp') then 'yelp'
  else if test(text, 'line') then 'line'
  else if test(text, 'maxi') then 'maxi'
  else if test(text, 'in') then 'in'
  else if test(text, 'epi') then 'epi'
  else if test(text, 'ted') then 'ted'
  else if test(text, 'oo') then 'oo'
  else if test(text, 'ok') then 'ok'
  else if test(text, 'dd') then "dd"
  else if test(text, 'sky') then 'sky'
  else if test(text, 'cc') then 'cc'
  else if test(text, 'ps') then 'ps'
  else if test(text, 'be') then 'be'
  else if test(text, 'aa') then 'aa'
  else if test(text, 'atm') then 'atm'
  else if test(text, 'jello') then 'jello'
  else if test(text, 'tea') then 'tea'
  else if test(text, 'xs') then 'xs'
  else if test(text, 'yolo') then 'yolo'
  else if test(text, 'ib') then 'ib'
  else if test(text, 'imo') then 'imo'
  else if test(text, 'yum') then 'yum'  # Words and letter combos
  else if test(text, 'a_2') then 'a_2'
  else if test(text, 'a_3') then 'a_3'
  else if test(text, 'b_2') then 'b_2'
  else if test(text, 'b_3') then 'b_3'
  else if test(text, 'c_2') then 'c_2'
  else if test(text, 'd_2') then 'd_2'
  else if test(text, 'e_2') then 'e_2'
  else if test(text, 'f_2') then 'f_2'
  else if test(text, 'g_2') then 'g_2'
  else if test(text, 'g_3') then 'g_3'
  else if test(text, 'h_2') then 'h_2'
  else if test(text, 'i_2') then 'i_2'
  else if test(text, 'i_3') then 'i_3'
  else if test(text, 'j_2') then 'j_2'
  else if test(text, 'l_2') then 'l_2'
  else if test(text, 'l_3') then 'l_3'
  else if test(text, 'm_2') then 'm_2'
  else if test(text, 'm_3') then 'm_3'
  else if test(text, 'n_2') then 'n_2'
  else if test(text, 'n_3') then 'n_3'
  else if test(text, 'o_2') then 'o_2'
  else if test(text, 'o_3') then 'o_3'
  else if test(text, 'p_2') then 'p_2'
  else if test(text, 'p_3') then 'p_3'
  else if test(text, 'q_2') then 'q_2'
  else if test(text, 'r_2') then 'r_2'
  else if test(text, 'r_3') then 'r_3'
  else if test(text, 's_2') then 's_2'
  else if test(text, 's_3') then 's_3'
  else if test(text, 't_2') then 't_2'
  else if test(text, 't_3') then 't_3'
  else if test(text, 'v_2') then 'v_2'
  else if test(text, 'w_2') then 'w_2'
  else if test(text, 'x_2') then 'x_2'
  else if test(text, 'y_2') then 'y_2'
  else false

test = (text, query) ->
  if text[0..(query.length - 1)] + '' == query.split('') + ''
    query
  else false

specialCase = (text, result, rows) ->
  # console.log 'special'
  rows[rows.length - 1]['letters'].push(result)
  text.slice(result.length)

@getWidth = () ->
  if (window.innerWidth > 0) then window.innerWidth else screen.width

@IconWriterUpdate = (objects) ->
  IconWriter.update({}, {$set: objects})

@IconWriterFind = (field) ->
  IconWriter.findOne()[field]

Handlebars.registerHelper 'title', (appName) ->
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
    when '!?' then 'Just Say It!'
    when '_' then 'Yo'
    when '^' then 'Mystery Box'
    when '-' then 'Onavo Extend'
    when '!' then '!'
    when '+' then 'Gneo'
    when '$' then 'Cash'
    when 'in' then 'LinkedIn'
    when 'dragon' then 'Dragon'
    when 'epi' then 'Epicurious'
    when 'netflix' then 'Netflix'
    when 'ted' then 'TED'
    when 'vision' then 'Vision Test'
    when 'oo' then 'OO Phone'
    when 'ok' then 'Keep it Local'
    when 'heart' then 'We Heart Pics'
    when 'dd' then "Dunkin' Donuts"
    when 'whatsapp' then 'WhatsApp'
    when 'tweet' then 'Twitter'
    when '2048' then '2048'
    when 'angrybirds' then 'Angry Birds'
    when 'candycrush' then 'Candy Crush'
    when 'clashofclans' then 'Clash of Clans'
    when 'fruitninja' then 'Fruit Ninja'
    when 'instagram' then 'Instagram'
    when 'line' then 'LINE'
    when 'messenger' then 'Messenger'
    when 'minecraft' then 'Minecraft'
    when 'shazam' then 'Shazam'
    when 'snapchat' then 'Snapchat'
    when 'templerun' then 'Temple Run'
    when 'youtube' then 'YouTube'
    when 'airplane' then 'Plane Finder'
    when 'check' then 'Clear'
    when 'yelp' then 'Yelp'
    when '42' then 'PCalc'
    when 'smile' then 'Waze'
    when 'holybible' then 'Bible'
    when 'creeper' then 'Plants/Zombies'
    when 'joyous' then 'Toca Salon 2'
    when 'cc' then 'CamCard'
    when 'book' then 'iBooks'
    when 'sky' then 'Sky+'
    when 'ps' then 'Photoshop'
    when 'be' then 'Portfolio'
    when 'yum' then 'Yummly'
    when 'xs' then 'Sizer'
    when 'jello' then 'Jell-o'
    when 'tea' then 'Tea'
    when 'aa' then 'Discourse'
    when 'atm' then 'Find My ATM'
    when 'ib' then 'Ibotta'
    when 'imo' then 'imo'
    when 'quotes' then 'Daily Quotes'
    when 'sunny' then 'Weather AUS'
    when 'globe' then 'Living Earth'
    when 'scarykids' then 'Scary Tale'
    when 'guitar' then 'GarageBand'
    when 'burger' then 'Dine-o-Matic'
    when 'fixit' then 'TF2 Recipes'
    when 'unimpressed' then 'Hobbit Movies'
    when 'interested' then 'Thumbelina'
    when 'starry' then 'Ranky'
    when 'jpyen' then 'DailyCost'
    when 'maxi' then 'MaxiCalc'
    when 'pressplay' then 'Telly'
    when 'musicnote' then 'I Am Composer'
    when 'hello' then 'Evernote Hello'
    when 'kitty' then 'Cutest Paw'
    when 'asleep' then 'Baby Monitor'
    when 'determined' then 'Splat Attack'
    when 'a_2' then 'Airbnb'
    when 'a_3' then 'Alphabuild'
    when 'b_2' then 'Beats Music'
    when 'b_3' then 'Byword'
    when 'c_2' then 'CityHour'
    when 'd_2' then 'ZEDGE'
    when 'e_2' then 'Evermeeting'
    when 'f_2' then 'Font Candy'
    when 'g_2' then 'Guitar Tabs'
    when 'g_3' then 'Google Maps'
    when 'h_2' then 'Halftone'
    when 'i_2' then 'Instapaper'
    when 'i_3' then 'iLoader 2'
    when 'j_2' then 'Jukely'
    when 'l_2' then 'Layout'
    when 'l_3' then 'LoungeBuddy'
    when 'm_2' then 'Memoir'
    when 'm_3' then 'Mixel'
    when 'n_2' then 'OneNote'
    when 'n_3' then 'Wallpapr'
    when 'o_2' then 'Chase Mobile'
    when 'o_3' then 'Weathertron'
    when 'p_2' then 'Paypal'
    when 'p_3' then 'Pandora'
    when 'q_2' then 'Quizlet'
    when 'r_2' then 'Roon'
    when 'r_3' then 'Road Inc.'
    when 's_2' then 'Snapguide'
    when 's_3' then 'Sipp'
    when 't_2' then 'Tango'
    when 't_3' then 'Trevi'
    when 'v_2' then 'Vango'
    when 'w_2' then 'Wikiweb'
    when 'x_2' then 'musiXmatch'
    when 'y_2' then 'DailyCost'
    else 'MissingNo'

  # c = document.getElementById("canvas")
  # ctx = c.getContext("2d")
  # img = $('.iphone')[0]
  # ctx.scale .5, .5
  # ctx.drawImage img, 10, 10



  # img = $('.iphone')[0] #/ provide the image
  # canvas = document.getElementById("canvas") #/ provide the canvas element
  # ctx = canvas.getContext("2d") #/ context
  # canvas.width = img.width #/ set width = image width
  # canvas.height = img.height #/ set height = image height
  # ctx.drawImage img, 0, 0 #/ draw image 1:1 @ [0, 0]



@drawImage = (opts) ->
  throw ("A canvas is required")  unless opts.canvas
  throw ("Image is required")  unless opts.image

  # get the canvas and context
  canvas = opts.canvas

  canvas.width = $('#canvas').width() # ?????????
  canvas.height = $('#canvas').height() # ??????????

  console.log canvas
  context = canvas.getContext("2d")
  image = opts.image

  # now default all the dimension info
  srcx = opts.srcx or 0
  srcy = opts.srcy or 0
  srcw = opts.srcw or image.naturalWidth
  srch = opts.srch or image.naturalHeight
  desx = opts.desx or srcx
  desy = opts.desy or srcy
  desw = opts.desw or srcw
  desh = opts.desh or srch
  auto = opts.auto

  # finally query the various pixel ratios
  devicePixelRatio = window.devicePixelRatio or 1
  backingStoreRatio = context.webkitBackingStorePixelRatio or context.mozBackingStorePixelRatio or context.msBackingStorePixelRatio or context.oBackingStorePixelRatio or context.backingStorePixelRatio or 1
  ratio = devicePixelRatio / backingStoreRatio

  # ensure we have a value set for auto.
  # If auto is set to false then we
  # will simply not upscale the canvas
  # and the default behaviour will be maintained
  auto = true  if typeof auto is "undefined"

  # upscale the canvas if the two ratios don't match
  if auto and devicePixelRatio isnt backingStoreRatio
    oldWidth = canvas.width
    oldHeight = canvas.height
    canvas.width = oldWidth * ratio
    canvas.height = oldHeight * ratio
    canvas.style.width = oldWidth + "px"
    canvas.style.height = oldHeight + "px"


    # now scale the context to counter
    # the fact that we've manually scaled
    # our canvas element

    # context.scale ratio, ratio ?????????????

  context.drawImage image, srcx, srcy, srcw, srch, desx, desy, desw, desh
  return


  # var c, ctx, img;
  # c = document.getElementById("canvas");
  # c.style.width = "640px";
  # c.style.height = "640px";
  # ctx = c.getContext("2d");
  # img = $('.iphone')[0];
  # ctx.drawImage(img, 0, 0);



  # var can = document.getElementById("canvas");
  # var ctx = can.getContext("2d");
  # var scaleFactor = backingScale(ctx);

  # if (scaleFactor > 1) {
  #     can.width = can.width * scaleFactor;
  #     can.height = can.height * scaleFactor;
  #     // update the context for the new canvas scale
  #     var ctx = can.getContext("2d");
  # }

  # img = $('.iphone')[0];
  # ctx.drawImage(img, 0, 0);

# @backingScale = (context) ->
#   return window.devicePixelRatio  if window.devicePixelRatio > 1  if "devicePixelRatio" of window
#   1