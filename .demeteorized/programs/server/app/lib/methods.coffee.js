(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// lib/methods.coffee.js                                               //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };
                                                                       //
Meteor.methods({                                                       // 1
  saveDataURL: function(fileName, dataUrl) {                           //
    var BASE, __PUBLIC_FOLDER__, base, buffer, dataString, e, error, fileTree, fs, fullFileName, newDir, path;
    if (Meteor.isServer && process.env.ROOT_URL !== 'http://localhost:3000/') {
      fileName = decodeURIComponent(fileName);                         //
      console.log("Filename is: " + fileName);                         //
      if (dataUrl) {                                                   //
        console.log("Data URL extant");                                //
      }                                                                //
      fs = Npm.require("fs");                                          //
      path = Npm.require("path");                                      //
      base = path.resolve('.');                                        //
      console.log('Base is: ' + base);                                 //
      BASE = fs.realpathSync(base);                                    //
      console.log('BASE is: ' + BASE);                                 //
      fileTree = new Glob('*', {                                       //
        debug: false,                                                  //
        cwd: BASE                                                      //
      }, function(err, matches) {});                                   //
      console.log(fileTree);                                           //
      try {                                                            // 22
        newDir = fs.mkdirSync(process.env.CLOUD_DIR + '/iconwriter/savedimg');
        console.log("newDir is: " + newDir);                           //
      } catch (error) {                                                //
        e = error;                                                     //
        console.log(e);                                                //
      }                                                                //
      __PUBLIC_FOLDER__ = fs.realpathSync(process.env.CLOUD_DIR + '/iconwriter/savedimg');
      console.log('__PUBLIC_FOLDER__ is: ' + __PUBLIC_FOLDER__);       //
      fileTree = new Glob('*', {                                       //
        debug: false,                                                  //
        cwd: __PUBLIC_FOLDER__                                         //
      }, function(err, matches) {});                                   //
      console.log(fileTree);                                           //
      if (indexOf.call(fileTree, fileName) >= 0) {                     //
        console.log('FILE ALREADY EXISTS - TERMINATING SAVE PROCESS');
        return;                                                        // 35
      }                                                                //
      dataString = dataUrl.split(",")[1];                              //
      if (dataString) {                                                //
        console.log("dataString extant");                              //
      }                                                                //
      buffer = new Buffer(dataString, "base64");                       //
      if (buffer) {                                                    //
        console.log("Buffer extant");                                  //
      }                                                                //
      fullFileName = __PUBLIC_FOLDER__ + '/' + fileName;               //
      console.log('Full file name is: ' + fullFileName);               //
      fs.writeFileSync(fullFileName, buffer, "binary", function(err) {
        if (err) {                                                     //
          throw err;                                                   // 45
        }                                                              //
        return console.log("Saved successfully.");                     //
      });                                                              //
      __PUBLIC_FOLDER__ = fs.realpathSync(process.env.CLOUD_DIR + '/iconwriter/savedimg');
      console.log('NEW __PUBLIC_FOLDER__ is: ' + __PUBLIC_FOLDER__);   //
      fileTree = new Glob('*', {                                       //
        debug: false,                                                  //
        cwd: __PUBLIC_FOLDER__                                         //
      }, function(err, matches) {});                                   //
      return console.log(fileTree);                                    //
    }                                                                  //
  }                                                                    //
});                                                                    //
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=methods.coffee.js.map
