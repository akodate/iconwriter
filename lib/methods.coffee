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

@saveDataUrl = (fileName, dataUrl) ->
  dataString = dataUrl.split(",")[1]
  buffer = new Buffer(dataString, "base64")
  extension = dataUrl.match(/\/(.*)\;/)[1]
  fs = require("fs")
  fullFileName = fileName + "." + extension
  fs.writeFileSync fullFileName, buffer, "binary"