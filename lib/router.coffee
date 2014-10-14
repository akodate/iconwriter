Router.configure

  layoutTemplate: 'layout',
  loadingTemplate: 'loading'



Router.map( ->

  @route("img", {
    path: "/img/:path(*)"
    where: "server"
    action: ->
      console.log "cwd: " + process.cwd()
      fs = Npm.require("fs")
      path = '/' + @params.path
      basedir = fs.realpathSync(process.env.APP_DIR + '/programs/web.browser/app')
      # basedir = process.env.APP_DIR + '/programs/web.browser/app/'
      console.log "will serve static content @ (base): " + basedir
      console.log "will serve static content @ (path): " + path
      file = fs.readFileSync(basedir + path)
      headers =
        "Content-type": "image/jpg"
        "Content-Disposition": "attachment; filename=" + path.slice(1)

      @response.writeHead 200, headers
      console.log @response
      return @response.end file
  })

  @route('home', {
    path: '/',
    onAfterAction: ->
      GAnalytics.pageview()
  })
  @route('home', {
    path: '/-:extension',
    waitOn: ->
      # $("meta[property='og:image']").attr("content", "http://iconwriter.wtf/" + @params.extension + ".png")
      $("meta[property='og:image']").attr("content", document.location.origin + '/img/' + @params.extension + '.jpg')
      $("meta[property='og:type']").attr("content", "iconwriter:icon_message" )
      $("meta[property='og:title']").attr("content", "Check out this message made entirely from app icons!")
      $("meta[property='og:description']").attr("content", "Do you have something you'd like to write too?")
      $("meta[property='og:site_name']").attr("content", "IconWriter")
      $("meta[property='og:url']").attr("content", document.location.href)
    onAfterAction: ->
      # Meteor.call 'serverMethod'
      generateTable(@params.extension)
      GAnalytics.pageview()
  })
  @route('home', {
    path: '/:input',
    onAfterAction: ->
      # Meteor.call 'serverMethod'
      generateTable(@params.input)
      GAnalytics.pageview()
  })
  @route('about', {
    path: '/about',
    onAfterAction: ->
      GAnalytics.pageview()
  })
)



# Router.onBeforeAction('loading')