Meteor.methods

  saveDataURL: (fileName, dataUrl) ->

    if Meteor.isServer && process.env.ROOT_URL != 'http://localhost:3000/'

      console.log "Filename is: " + fileName
      console.log "Data URL is: " + dataUrl

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
      console.log "dataString is: " + dataString
      buffer = new Buffer(dataString, "base64")
      if buffer
        console.log "Buffer extant"
      # extension = dataUrl.match(/\/(.*)\;/)[1]
      fullFileName = __PUBLIC_FOLDER__ + '/' + fileName # + "." + extension
      console.log 'Full file name is: ' + fullFileName
      fs.writeFileSync fullFileName, buffer, "binary", (err) ->
        throw err  if err
        console.log "Saved successfully."

      __PUBLIC_FOLDER__ = fs.realpathSync(process.env.APP_DIR + '/programs/web.browser/app')
      console.log '__PUBLIC_FOLDER__ is: ' + __PUBLIC_FOLDER__
      fileTree = new Glob('*', {debug: false, cwd: __PUBLIC_FOLDER__}, (err, matches) -> )
      console.log fileTree