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
    path: '/:input',
    onAfterAction: ->
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