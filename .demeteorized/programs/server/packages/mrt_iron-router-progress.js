(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var global = Package.meteor.global;
var meteorEnv = Package.meteor.meteorEnv;
var Symbol = Package['ecmascript-runtime'].Symbol;
var Map = Package['ecmascript-runtime'].Map;
var Set = Package['ecmascript-runtime'].Set;
var meteorBabelHelpers = Package['babel-runtime'].meteorBabelHelpers;
var Promise = Package.promise.Promise;

/* Package-scope variables */
var __coffeescriptShare;

(function(){

//////////////////////////////////////////////////////////////////////////
//                                                                      //
// packages/mrt_iron-router-progress/packages/mrt_iron-router-progress. //
//                                                                      //
//////////////////////////////////////////////////////////////////////////
                                                                        //
(function () {

///////////////////////////////////////////////////////////////////////
//                                                                   //
// packages/mrt:iron-router-progress/notice.coffee.js                //
//                                                                   //
///////////////////////////////////////////////////////////////////////
                                                                     //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
var notice;

notice = "%cYou're using a deprecated version of %cIronRouterProgress%c.\n%cPlease run the following commands in your project:%c\n  meteor remove mrt:iron-router-progress\n  meteor add multiply:iron-router-progress\n%cYou can read more about the changes at https://github.com/Multiply/iron-router-progress";

Meteor.startup(function() {
  if (Meteor.isClient) {
    return console.log(notice, "font-size:2em;font-weight:400;color:red", "font-size:2em;font-weight:400;color:red;font-weight:600", "font-size:2em;font-weight:400;color:red", "font-size:1.5em;font-weight:600", "font-size:1.5em;font-family:'Lucida Console',Monaco,monospace", "font-size:1.5em;font-weight:600");
  } else {
    return console.log(notice.replace(/%c/g, ''));
  }
});
///////////////////////////////////////////////////////////////////////

}).call(this);

//////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package['mrt:iron-router-progress'] = {};

})();

//# sourceMappingURL=mrt_iron-router-progress.js.map
