Template.likes.rendered = ->

  Meteor.setTimeout (->
    twttr.events.bind "click", (event) ->
      opts = generateOpts("#canvas", ".iphone")
      drawImage opts, true
      canvasResizer true
      filename = document.location.pathname.slice(1) + '.jpg'
      saveCanvas(event.target, 'canvas', filename)

      $("meta[name='twitter:card']").attr("content", "summary_large_image")
      $("meta[name='twitter:title']").attr("content", "Check out this message made out of app icons!")
      $("meta[name='twitter:description']").attr("content", "Do you have something you'd like to write too?")
      $("meta[name='twitter:image:src']").attr("content", document.location.origin + '/img/' + filename + '.jpg')
  ), 2000