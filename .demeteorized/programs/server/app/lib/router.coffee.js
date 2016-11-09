(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// lib/router.coffee.js                                                //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Router.configure({                                                     // 1
  layoutTemplate: 'layout',                                            //
  loadingTemplate: 'loading'                                           //
});                                                                    //
                                                                       //
Router.map(function() {                                                // 8
  this.route("img", {                                                  //
    path: "/img/:path(*)",                                             //
    where: "server",                                                   //
    action: function() {                                               //
      var basedir, e, error, file, fs, headers, path;                  // 14
      console.log("Time: " + new Date());                              //
      console.log("------------------------------------------------");
      console.log("Request headers for img/:path(*): ");               //
      console.log(this.request.headers);                               //
      console.log("------------------------------------------------");
      console.log("cwd: " + process.cwd());                            //
      fs = Npm.require("fs");                                          //
      path = decodeURIComponent('/' + this.params.path);               //
      if (process.env.ROOT_URL !== 'http://localhost:3000/') {         //
        basedir = fs.realpathSync(process.env.CLOUD_DIR + '/iconwriter/savedimg');
      } else {                                                         //
        basedir = fs.realpathSync(process.env.PWD + '/public');        //
      }                                                                //
      console.log("Will serve static content at: " + basedir + path);  //
      try {                                                            // 27
        file = fs.readFileSync(basedir + path);                        //
      } catch (error) {                                                //
        e = error;                                                     //
        throw e;                                                       // 30
      }                                                                //
      headers = {                                                      //
        "Content-type": "image/jpg",                                   //
        "Content-Disposition": "attachment; filename=" + path.slice(1)
      };                                                               //
      this.response.writeHead(200, headers);                           //
      console.log('Image route accessed');                             //
      return this.response.end(file);                                  // 37
    }                                                                  //
  });                                                                  //
  this.route('homepage', {                                             //
    path: '/',                                                         //
    render: 'home',                                                    //
    onAfterAction: function() {                                        //
      generateTable('iconwriter');                                     //
      return GAnalytics.pageview();                                    //
    }                                                                  //
  });                                                                  //
  this.route('url', {                                                  //
    path: '/-:extension',                                              //
    waitOn: function() {                                               //
      $("meta[property='og:image']").attr("content", document.location.origin + '/img/' + encodeURIComponent(this.params.extension + '.jpg'));
      $("meta[property='og:type']").attr("content", "iconwriter:icon_message");
      $("meta[property='og:title']").attr("content", "What does your name look like spelled with app icons?");
      $("meta[property='og:description']").attr("content", "Write whatever you want on an iPhone home screen with IconWriter! A 20-icon love letter? An Android fanpost? Or maybe a nice home screen arrangement? There are over 100 icons to choose from!");
      return $("meta[property='og:url']").attr("content", document.location.origin + '/-' + encodeURIComponent(this.params.extension));
    },                                                                 //
    onAfterAction: function() {                                        //
      generateTable(this.params.extension);                            //
      return GAnalytics.pageview();                                    //
    }                                                                  //
  });                                                                  //
  this.route('about', {                                                //
    path: '/about',                                                    //
    onAfterAction: function() {                                        //
      return GAnalytics.pageview();                                    //
    }                                                                  //
  });                                                                  //
  return this.route('home', {                                          //
    path: '/:input',                                                   //
    waitOn: function() {                                               //
      $("meta[name='twitter:card']").attr("content", "summary_large_image");
      $("meta[name='twitter:title']").attr("content", "What does your name look like spelled with app icons?");
      $("meta[name='twitter:description']").attr("content", "Write whatever you want on an iPhone home screen with IconWriter! A 20-icon love letter? An Android fanpost? Or maybe a nice home screen arrangement? There are over 100 icons to choose from!");
      return $("meta[name='twitter:image:src']").attr("content", document.location.origin + '/img/' + this.params.input + '.jpg');
    },                                                                 //
    onAfterAction: function() {                                        //
      generateTable(this.params.input);                                //
      return GAnalytics.pageview();                                    //
    }                                                                  //
  });                                                                  //
});                                                                    // 8
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=router.coffee.js.map
