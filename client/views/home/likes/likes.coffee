Template.likes.rendered = ->

  Meteor.setTimeout (->
    twttr.events.bind "click", (event) ->
      opts = generateOpts("#canvas", ".iphone")
      drawImage opts, true
      canvasResizer true
      filename = document.location.pathname.slice(1) + '.jpg'
      saveCanvas(event.target, 'canvas', filename)

      $("meta[name='twitter:card']").attr("content", "summary_large_image")
      $("meta[name='twitter:title']").attr("content", "What does your name look like spelled with app icons?")
      $("meta[name='twitter:description']").attr("content", "Write whatever you want on an iPhone home screen with IconWriter! A 20-icon love letter? An Android fanpost? Or maybe a nice home screen arrangement? There are over 100 icons to choose from!")
      $("meta[name='twitter:image:src']").attr("content", document.location.origin + '/img/' + filename + '.jpg')
  ), 2000

Template.likes.helpers

  isIOSChrome: ->
    navigator.userAgent.match('CriOS')