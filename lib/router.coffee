Router.configure
  layoutTemplate: 'layout',
  loadingTemplate: 'loading'

Router.map( ->
  @route('home', {
    path: '/',
    onAfterAction: ->
      GAnalytics.pageview()
  })
  @route('home', {
    path: '/-:extension',
    waitOn: ->
      $("meta[property='og:image']").attr("content", "http://iconwriter.wtf/" + @params.extension + ".png")
      $("meta[property='og:type']").attr("content", "iconwriter:icon_message" )
      $("meta[property='og:title']").attr("content", "Dynamic title")
      $("meta[property='og:description']").attr("content", "Dynamic description")
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

Router.onBeforeAction('loading')