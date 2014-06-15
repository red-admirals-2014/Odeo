
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax({
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js",
    dataType: 'script',
    cache: true
    })


window.fbAsyncInit = function(){
  FB.init({
    appId: '<%= ENV["FACEBOOK_KEY"] %>', cookie: true
})
  FB.getLoginStatus(function(response){
    fbApiInit = true;
  })

}



