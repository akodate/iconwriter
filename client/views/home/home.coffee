ILLEGALCHARS = new RegExp(/[^a-z0-9\s\_.?!+$]/g)
THREETYPES = 'abgilmnoprst'
TWOTYPES = 'cdefhjqvwxy'
ONETYPE = 'kuz'

@Table = new Meteor.Collection(null)
@IconWriter = new Meteor.Collection(null)

IconWriter.insert({iPhoneDisplay: true})
Table.insert({})







Template.home.rendered = ->

  setInputWithURI()
  $('.writing-area').hide()
  setWindowResizeListener()







Template.home.events
  "keydown .writing-box, click .submit": (event, ui) ->
    if event.keyCode == 13 || event.keyCode == undefined
      event.preventDefault()
      event.stopPropagation()
      submitButtonFlash()
      text = $('.writing-box')[0].value.toLowerCase()
      generateTable(text)
      false
    else if event.keyCode != 13
      true
    else
      event.preventDefault()
      event.stopPropagation()
      false

  # "click .essay": (event, ui) ->
  #   iPhoneDisplay = IconWriterFind('iPhoneDisplay')
  #   IconWriterUpdate({iPhoneDisplay: !iPhoneDisplay})
  #   unless IconWriterFind('iPhoneDisplay')
  #     text = $('.writing-box')[0].value.toLowerCase()
  #     generateTable(text)

  "click .legend": (event, ui) ->
    if window.matchMedia("(max-width: 768px)").matches
      target = $($('.target')[1])
    else
      target = $($('.target')[0])
    target.show()
    if target.hasClass('fadeIn')
      fadeOutLegend(target)
    else
      fadeInLegend(target)
      scrollToLegend() if window.matchMedia("(max-width: 768px)").matches

  "focus .btn": (event, ui) ->
    $('.btn').blur()

  "click .legend-text": (event, ui) ->
    if navigator.userAgent.match('Firefox')
      text = event.target.textContent
      $('.writing-box').val($('.writing-box').val() + text)
    else
      text = event.target.outerText
      $('.writing-box').val($('.writing-box').val() + text)
    generateTable($('.writing-box').val())

  "click #download": (event, ui) ->
    opts = generateOpts("#canvas", ".iphone")
    drawImage opts, false
    canvasResizer false
    filename = document.location.pathname.slice(1) + '.jpg'
    downloadCanvas(event.target, 'canvas', filename)

  "click .fbButton": (event, ui) ->
    shareButtonFlash()
    newURL = document.location.origin + '/-' + document.location.pathname.slice(1)
    opts = generateOpts("#canvas", ".iphone")
    drawImage opts, true
    canvasResizer true
    filename = document.location.pathname.slice(1) + '.jpg'
    saveCanvas(event.target, 'canvas', filename)
    FB.ui
      method: "share"
      href: newURL
    , (response) ->







Template.home.helpers

  table: ->
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

  isIOSChrome: ->
    navigator.userAgent.match('CriOS')







# Basic helpers

@setInputWithURI = ->
  path = window.location.pathname[1..-1]
  if path == ''
    Router.go('home', {input: 'iconwriter'})
  else
    $('#input').val(decodeURIComponent(path))

@setPhoneWidth = ->
  width = getWidth()
  if width < 768
    if width < 480
      width = width - 10
    $('.iphone-container').css('margin-left', (width - 321) / 2 + 'px')
    $('.icon-table-container').css('margin-left', (width - 321) / 2 + 'px')
  else
    $('.iphone-container').css('margin-left', '')
    $('.icon-table-container').css('margin-left', '')

@setWindowResizeListener = ->
  $( window ).resize ->
    $('#main').css(height: '100%')
    $('#main').css(height: $('body').height() - $('.navbar-default').height() - 2)
    setPhoneWidth()

@generateTable = (text) ->
  text = text.replace(ILLEGALCHARS, '')
  return unless matchingURL(text)
  Meteor.setTimeout (->
    updateTwitterValues('http://iconwriter.wtf' + document.location.pathname, "Check out this message made out of app icons!")
  ), 1000
  text = decodeURIComponent(text)
  hideIcons()
  rows = []
  Table.update({}, {rows})
  text = text.split('')
  maxRows = setMaxRows()
  rows = fillRows(rows, text, maxRows)
  diversifyIcons(rows)
  Table.update({}, {rows})
  refreshIcons()

@matchingURL = (text) ->
  if encodeURIComponent(text) != window.location.pathname[1..-1]
    Router.go('home', {input: text})
    false
  else
    true

@updateTwitterValues = (share_url, title) ->
  $('.twitter-section').html "&nbsp;"
  $('.twitter-section').html "<a href=\"https://twitter.com/share\" class=\"twitter-share-button\" data-url=\"" + share_url + "\" data-text=\"" + title + "\" data-counturl=\"http://iconwriter.wtf\">Tweet</a>"
  twttr.widgets.load()

@setMaxRows = ->
  if IconWriterFind('iPhoneDisplay')
    5
  else
    75

@fillRows = (rows, text, maxRows) ->
  while text.length > 0 && rows.length < maxRows
    rows.push {}
    rows[rows.length - 1]['letters'] = []
    for [0..3]
      if text.length > 0
        if result = isSpecialCase(text)
          text = specialCase(text, result, rows)
        else
          rows[rows.length - 1]['letters'].push(text[0])
          text = text.slice(1)
  return rows

@diversifyIcons = (rows) ->
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

@refreshIcons = ->
  Meteor.setTimeout ( ->
    hideIcons()
    showIcons()
  ), 10

@hideIcons = ->
  $('.icon').hide()
  $('.icon-text').hide()
  $('.icon').addClass('hidden')
  $('.icon-text').addClass('hidden-text')

@showIcons = ->
  Meteor.setTimeout ( ->
    if $('.hidden')[0] || $('.hidden-text')[0]
      $($('.hidden')[0]).show()
      $($('.hidden-text')[0]).show()
      $($('.hidden')[0]).removeClass('hidden')
      $($('.hidden-text')[0]).removeClass('hidden-text')
      showIcons()
  ), 30

@submitButtonFlash = ->
  $('.submit').css
    backgroundColor: 'white'
  $('.submit').animate
    backgroundColor: 'black',
    1500

@shareButtonFlash = ->
  $('.fbButton').css
    backgroundColor: 'white'
  $('.fbButton').animate
    backgroundColor: '#3b5998',
    1500

@generateOpts = (canvasID, imageClass) ->
  opts = {}
  opts.canvas = $(canvasID)[0]
  opts.image = $(imageClass)[0]
  opts

@downloadCanvas = (link, canvasId, filename) ->
  filename = decodeURIComponent(filename)
  link.href = document.getElementById(canvasId).toDataURL('image/jpeg')
  link.download = filename

@saveCanvas = (link, canvasId, filename) ->
  link.href = document.getElementById(canvasId).toDataURL('image/jpeg')
  Meteor.call 'saveDataURL', filename, link.href

@fadeOutLegend = (target) ->
  target.removeClass('fadeIn')
  target.addClass('fadeOut')
  Meteor.setTimeout (() ->
    target.hide()
  ), 500

@fadeInLegend = (target) ->
  target.removeClass('fadeOut')
  target.addClass('fadeIn')

@scrollToLegend = ->
  $('#main').animate(
    scrollTop: $('#legend2 > div.writing-container.target > div:nth-child(1) > h2').offset().top - 80,
    'slow')

@test = (text, query) ->
  if text[0..(query.length - 1)] + '' == query.split('') + ''
    query
  else
    false

@specialCase = (text, result, rows) ->
  rows[rows.length - 1]['letters'].push(result)
  text.slice(result.length)

@getWidth = ->
  if (window.innerWidth > 0) then window.innerWidth else screen.width

@IconWriterUpdate = (objects) ->
  IconWriter.update({}, {$set: objects})

@IconWriterFind = (field) ->
  IconWriter.findOne()[field]







# Special methods

@jQuery.fn.putCursorAtEnd = ->
  @each ->
    $(this).focus()
    if @setSelectionRange
      len = $(this).val().length * 2
      @setSelectionRange len, len
    else
      $(this).val $(this).val()
    @scrollTop = 999999

@drawImage = (opts, isPreview) ->
  throw ("A canvas is required")  unless opts.canvas
  throw ("Image is required")  unless opts.image

  # get the canvas and context
  canvas = opts.canvas

  canvas.width = $('#canvas').width()
  canvas.height = $('#canvas').height()

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

    context.scale ratio, ratio
    if isPreview
      context.translate 0,-200
    # context.translate(1280,0) # Sideways
    # context.rotate 0.5 * Math.PI # Sideways

  context.drawImage image, srcx, srcy, srcw, srch, desx, desy, desw, desh
  drawIcons(context, image, srcx, srcy, srcw, srch, desx, desy, desw, desh)
  drawText(context)

@drawIcons = (context, image, srcx, srcy, srcw, srch, desx, desy, desw, desh) ->
  context.scale 96/175, 96/175
  srcw = 175
  srch = 175
  desw = 175
  desh = 175
  for icon, index in $('.icon:visible')
    desx = $(icon).position().left * 175/96 * 2 + (30 * 175/96 * 2)
    desy = $(icon).position().top * 175/96 * 2 + (115 * 175/96 * 2)
    context.drawImage icon, srcx, srcy, srcw, srch, desx, desy, desw, desh

@drawText = (context) ->
  context.scale 175/96*2, 175/96*2
  context.font = "8.8px sans-serif";
  context.textAlign = 'center';
  context.fillStyle = 'rgba(220,220,220,1)'
  for iconText, index in $('.icon-text')
    desx = $(iconText).position().left + 30 + 61 / 2
    desy = $(iconText).position().top + 125
    context.fillText($(iconText).text(), desx, desy);

@canvasResizer = (isPreview) ->
  canvasRef = document.getElementById("canvas")
  ctx = canvasRef.getContext("2d")

  inMemCanvas = document.createElement("canvas")
  inMemCtx = inMemCanvas.getContext("2d")

  inMemCanvas.width = canvasRef.width
  inMemCanvas.height = canvasRef.height
  unless isPreview
    inMemCtx.scale .5, .5
  inMemCtx.drawImage canvasRef, 0, 0
  if isPreview
    canvasRef.width = 1200 # 598
    canvasRef.height = 630 # 1280
  else
    canvasRef.width = 598
    canvasRef.height = 1280
  # canvasRef.width = 1280 # Sideways
  # canvasRef.height = 598 # Sideways
  ctx.drawImage inMemCanvas, 0, 0