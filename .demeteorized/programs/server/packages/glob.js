(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var global = Package.meteor.global;
var meteorEnv = Package.meteor.meteorEnv;

/* Package-scope variables */
var Glob;

(function(){

///////////////////////////////////////////////////////////////////////
//                                                                   //
// packages/glob/glob.js                                             //
//                                                                   //
///////////////////////////////////////////////////////////////////////
                                                                     //
var Future = Npm.require("fibers/future");
var glob = Npm.require("glob");

Glob = function(pattern, options){
    var future = new Future();
    var cb = future.resolver();

    glob(pattern, options || {}, cb);

    return future.wait();
};
///////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
(function (pkg, symbols) {
  for (var s in symbols)
    (s in pkg) || (pkg[s] = symbols[s]);
})(Package.glob = {}, {
  Glob: Glob
});

})();

//# sourceMappingURL=glob.js.map
