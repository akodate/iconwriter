console.log process.env

console.log '*****************************************************************************************'

# Meteor.startup () ->
#   logPublicFolder()

# @logPublicFolder = ->
#   fs = Npm.require("fs")
#   path = Npm.require("path")
#   base = path.resolve('.')
#   console.log 'Base is: ' + base

#   __PUBLIC_FOLDER__ = fs.realpathSync(process.env.APP_DIR + '/programs/web.browser/app')
#   console.log '__PUBLIC_FOLDER__ is: ' + __PUBLIC_FOLDER__

#   fileTree = new Glob('*', {debug: false, cwd: __PUBLIC_FOLDER__}, (err, matches) -> )
#   console.log fileTree