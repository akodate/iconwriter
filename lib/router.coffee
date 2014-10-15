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
      console.log "Request headers: "
      console.log @request.headers
      console.log "------------------------------------------------"
      console.log "cwd: " + process.cwd()
      fs = Npm.require("fs")
      path = '/' + @params.path
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
      $("meta[property='og:image']").attr("content", document.location.origin + '/img/' + @params.extension + '.jpg')
      $("meta[property='og:type']").attr("content", "iconwriter:icon_message" )
      $("meta[property='og:title']").attr("content", "Check out this message made entirely from app icons!")
      $("meta[property='og:description']").attr("content", "Do you have something you'd like to write too?")
      $("meta[property='og:site_name']").attr("content", "IconWriter")
      $("meta[property='og:url']").attr("content", document.location.href)
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
    onAfterAction: ->
      generateTable(@params.input)
      GAnalytics.pageview()
  })
)



# Router.onBeforeAction('loading')