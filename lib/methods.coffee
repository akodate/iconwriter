Meteor.methods

  saveDataURL: (fileName, dataUrl) ->

    if Meteor.isServer && process.env.ROOT_URL != 'http://localhost:3000/'

      console.log "Filename is: " + fileName
      console.log "Data URL extant" if dataUrl

      fs = Npm.require("fs")
      path = Npm.require("path")
      base = path.resolve('.')
      console.log 'Base is: ' + base

      BASE = fs.realpathSync(base)
      console.log 'BASE is: ' + BASE
      fileTree = new Glob('*', {debug: false, cwd: BASE}, (err, matches) -> )
      console.log fileTree

      try
        newDir = fs.mkdirSync(process.env.CLOUD_DIR + '/iconwriter/savedimg')
        console.log "newDir is: " + newDir
      catch e
        console.log e

      __PUBLIC_FOLDER__ = fs.realpathSync(process.env.CLOUD_DIR + '/iconwriter/savedimg')
      console.log '__PUBLIC_FOLDER__ is: ' + __PUBLIC_FOLDER__
      fileTree = new Glob('*', {debug: false, cwd: __PUBLIC_FOLDER__}, (err, matches) -> )
      console.log fileTree

      if fileName in fileTree
        console.log 'FILE ALREADY EXISTS - TERMINATING SAVE PROCESS'
        return

      dataString = dataUrl.split(",")[1]
      console.log "dataString extant" if dataString
      buffer = new Buffer(dataString, "base64")
      console.log "Buffer extant" if buffer
      # extension = dataUrl.match(/\/(.*)\;/)[1]
      fullFileName = __PUBLIC_FOLDER__ + '/' + fileName # + "." + extension
      console.log 'Full file name is: ' + fullFileName
      fs.writeFileSync fullFileName, buffer, "binary", (err) ->
        throw err if err
        console.log "Saved successfully."

      __PUBLIC_FOLDER__ = fs.realpathSync(process.env.CLOUD_DIR + '/iconwriter/savedimg')
      console.log 'NEW __PUBLIC_FOLDER__ is: ' + __PUBLIC_FOLDER__
      fileTree = new Glob('*', {debug: false, cwd: __PUBLIC_FOLDER__}, (err, matches) -> )
      console.log fileTree