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
      console.log @params.extension
      $("meta[property='og:image']").attr("content", "http://iconwriter.wtf/" + @params.extension + ".png")
      debugger
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