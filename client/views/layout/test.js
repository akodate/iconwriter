// <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# iconwriter: http://ogp.me/ns/fb/iconwriter#">
//     <title>OG Sample Object - Sample Icon Message</title>

//     <meta property="fb:app_id" content="851835014840833">
//     <meta property="og:title" content="Sample Icon Message">
//     <meta property="og:image" content="http://iconwriter.wtf/iconwriter_phone.jpg">
//     <meta property="og:url" content="http://iconwriter.wtf/">
//     <meta property="og:type" content="iconwriter:icon_message">

//     <link type="text/css" rel="stylesheet" href="/stylesheets/app.css">
// <style type="text/css"></style></head>

// FB.api('/me/iconwriter:send', 'post', {
//     access_token: 'CAAMGvUt3ggEBAHfjS3nmZA8iUdqr32HXij9DOfVWEuwyCSEDuu6IlT8pw6UXBwi4BzVb5wnvBobswkE2wuTkipJr5FPySXaEuyvnBgCbmZCBXVM3WRCG9a5oqRMKTdikQ3Jz9qLnbngHWyQzrZA9wQ3R9qZAFc3m5Bpl3kY51cPhA0sCKQjhOPWHpHtZCmRvsskXIfarXyCds1zpFWt9O4HFjcKU0aNYZD',
//     icon_message: {
//       app_id: '851835014840833',
//       type: 'iconwriter:icon_message',
//       url: 'http://samples.ogp.me/852255034798831',
//       title: 'Better Icon Message 2',
//       image: 'https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png',
//       description: "Here's a basic description: 'The quick brown fox jumped over the lazy dogs."}
//     }, function(response) {
//   if (!response || response.error) {
//     console.log(response.error);
//   } else {
//     console.log(response);
//   }
// });

// Send object to application, get object ID, give object ID to FB.ui share_open_graph under action_properties
// 851835014840833|6b2a466cb9cd73a29b610a195e7b6663

FB.api('/app/objects/iconwriter:icon_message', 'post', {
    access_token: '851835014840833|6b2a466cb9cd73a29b610a195e7b6663',
    object: {
      app_id: '851835014840833',
      type: 'iconwriter:icon_message',
      url: 'http://iconwriter.wtf',
      title: 'Better Icon Message X',
      image: 'http://iconwriter.wtf/iconwriter_phone.jpg',
      description: "Here's a basic description: 'The quick brown fox jumped over the lazy dogs."}
    }, function(response) {
  if (!response || response.error) {
    console.log(response.error);
  } else {
    console.log(response);
  }
});

FB.api('/app/objects/iconwriter:icon_message', 'get', {
  access_token: '851835014840833|6b2a466cb9cd73a29b610a195e7b6663'
  },
  function(response) {
  if (!response || response.error) {
    console.log(response.error);
  } else {
    console.log(response);
  }
});

FB.ui({
  method: 'share_open_graph',
  action_type: 'iconwriter:send',
  action_properties: JSON.stringify({
    icon_message: '587593168012421',
  })
}, function(response){ console.log(response) });

// FB.api(
//   '10154625777820548',
//   'get',
//   { access_token: 'CAAMGvUt3ggEBAHfjS3nmZA8iUdqr32HXij9DOfVWEuwyCSEDuu6IlT8pw6UXBwi4BzVb5wnvBobswkE2wuTkipJr5FPySXaEuyvnBgCbmZCBXVM3WRCG9a5oqRMKTdikQ3Jz9qLnbngHWyQzrZA9wQ3R9qZAFc3m5Bpl3kY51cPhA0sCKQjhOPWHpHtZCmRvsskXIfarXyCds1zpFWt9O4HFjcKU0aNYZD',},
//   function(response) {
//     console.log(response);
//   }
// );

// FB.api('https://graph.facebook.com/me/staging_resources', 'post', {
//     access_token: 'CAAMGvUt3ggEBAHfjS3nmZA8iUdqr32HXij9DOfVWEuwyCSEDuu6IlT8pw6UXBwi4BzVb5wnvBobswkE2wuTkipJr5FPySXaEuyvnBgCbmZCBXVM3WRCG9a5oqRMKTdikQ3Jz9qLnbngHWyQzrZA9wQ3R9qZAFc3m5Bpl3kY51cPhA0sCKQjhOPWHpHtZCmRvsskXIfarXyCds1zpFWt9O4HFjcKU0aNYZD',
//     file: 'http://iconwriter.wtf/iconwriter_phone.jpg',
//     type: 'image/jpg'
//     }, function(response) {
//   if (!response || response.error) {
//     console.log(response.error);
//   } else {
//     console.log(response);
//   }
// });