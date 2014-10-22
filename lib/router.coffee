Router.configure

  layoutTemplate: 'layout',
  loadingTemplate: 'loading'



Router.map( ->

  @route("img", {
    path: "/img/:path(*)"
    where: "server"
    action: ->
      console.log "Time: " + new Date()
      console.log "------------------------------------------------"
      console.log "Request headers for img/:path(*): "
      console.log @request.headers
      console.log "------------------------------------------------"
      console.log "cwd: " + process.cwd()
      fs = Npm.require("fs")
      path = decodeURIComponent('/' + @params.path)
      if process.env.ROOT_URL != 'http://localhost:3000/'
        basedir = fs.realpathSync(process.env.CLOUD_DIR + '/iconwriter/savedimg')
      else
        basedir = fs.realpathSync(process.env.PWD + '/public')
      console.log "Will serve static content at: " + basedir + path
      try
        file = fs.readFileSync(basedir + path)
      catch e
        throw e
      headers =
        "Content-type": "image/jpg"
        "Content-Disposition": "attachment; filename=" + path.slice(1)

      @response.writeHead 200, headers
      console.log 'Image route accessed'
      return @response.end file
  })
  @route('homepage', {
    path: '/',
    render: 'home',
    onAfterAction: ->
      generateTable('iconwriter')
      GAnalytics.pageview()
  })
  @route('url', {
    path: '/-:extension',
    waitOn: ->

      $("meta[property='og:image']").attr("content", document.location.origin + '/img/' + encodeURIComponent @params.extension + '.jpg')
      $("meta[property='og:type']").attr("content", "iconwriter:icon_message" )
      $("meta[property='og:title']").attr("content", "What does your name look like spelled with app icons?")
      $("meta[property='og:description']").attr("content", "Write whatever you want on an iPhone home screen with IconWriter! A 20-icon love letter? An Android fanpost? Or maybe a nice home screen arrangement? There are over 100 icons to choose from!")
      $("meta[property='og:url']").attr("content", document.location.origin + '/-' + encodeURIComponent @params.extension)

    onAfterAction: ->
      generateTable(@params.extension)
      GAnalytics.pageview()
  })
  @route('about', {
    path: '/about',
    onAfterAction: ->
      GAnalytics.pageview()
  })
  @route('home', {
    path: '/:input',
    waitOn: ->
      $("meta[name='twitter:card']").attr("content", "summary_large_image")
      $("meta[name='twitter:title']").attr("content", "What does your name look like spelled with app icons?")
      $("meta[name='twitter:description']").attr("content", "Write whatever you want on an iPhone home screen with IconWriter! A 20-icon love letter? An Android fanpost? Or maybe a nice home screen arrangement? There are over 100 icons to choose from!")
      $("meta[name='twitter:image:src']").attr("content", document.location.origin + '/img/' + @params.input + '.jpg')
    onAfterAction: ->
      generateTable(@params.input)
      GAnalytics.pageview()
  })
)



# Router.onBeforeAction('loading')