$(document).ready( initialize )

  function initialize(){
    omniauth
    var recordView = new Modal();
    var playView = new Play();
    var noClip = new NoClips();

    var controller = new Controller(recordView, playView );
    controller.bindEventListener();
    controller.setProcessIdToSubmitForm();
};

function omniauth(){
 $('body').prepend('<div id="fb-root"></div>');

  $.ajax({
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js",
    dataType: 'script',
    cache: true
  });

  window.fbAsyncInit = function(){
    FB.init({
      appId: '<%= ENV["FACEBOOK_KEY"] %>', cookie: true
    })
    FB.getLoginStatus(function(response){
      fbApiInit = true;
    })
  };
};
