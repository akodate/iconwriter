Router.configure
  layoutTemplate: 'layout',
  loadingTemplate: 'loading'

Router.map( ->
  @route('home', {
    path: '/',
    onAfterAction: ->
      GAnalytics.pageview()
  })
)

Router.onBeforeAction('loading')

