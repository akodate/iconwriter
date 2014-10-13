# Meteor.methods

#   serverMethod: ->
#     if @isSimulation
#       console.log 'simulation'
#     else
#       console.log 'server-side'

@saveCanvas = ->

  # Get canvas contents as a data URL
  imgAsDataURL = imgCanvas.toDataURL("image/png")

  # Save image into localStorage
  try
    localStorage.setItem "elephant", imgAsDataURL
  catch e
    console.log "Storage failed: " + e
  return

@saveCanvas2 = ->
  fs = require("fs")
  path = require("path")

  # Save a file to the cloud directory.
  filename = path.join(process.env.CLOUD_DIR, "example.txt")

  # Write 'Hello World' to the file.
  fs.writeFile filename, "Hello World", (err) ->

    # When complete, read the file back and print it to the console.
    fs.readFile(filename, "example.txt")
    (err, data) ->
      console.log data # Hello World

Meteor.methods

  saveDataURL: (fileName, dataUrl) ->
    if Meteor.isServer

      fs = Npm.require("fs")
      path = Npm.require("path")
      base = path.resolve('.')
      console.log 'Base is: ' + base

      BASE = fs.realpathSync(base)
      console.log 'BASE is: ' + BASE
      fileTree = new Glob('*', {debug: false, cwd: BASE}, (err, matches) -> )
      console.log fileTree

      __PUBLIC_FOLDER__ = fs.realpathSync(process.env.APP_DIR + '/programs/web.browser/app')
      console.log '__PUBLIC_FOLDER__ is: ' + __PUBLIC_FOLDER__
      fileTree = new Glob('*', {debug: false, cwd: __PUBLIC_FOLDER__}, (err, matches) -> )
      console.log fileTree


      dataString = dataUrl.split(",")[1]
      buffer = new Buffer(dataString, "base64")
      # extension = dataUrl.match(/\/(.*)\;/)[1]
      fullFileName = __PUBLIC_FOLDER__ + '/' + fileName # + "." + extension
      console.log fullFileName
      fs.writeFileSync fullFileName, buffer, "binary"