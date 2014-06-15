$(document).ready(function(){
  eventListeners();

    $("#jquery_jplayer_1").jPlayer({
        ready: function(event) {
            $(this).jPlayer("setMedia", {
                mp3: "http://www.jplayer.org/audio/mp3/TSP-01-Cro_magnon_man.mp3",
                oga: "http://www.jplayer.org/audio/ogg/TSP-01-Cro_magnon_man.ogg"
            });
        },
        swfPath: "http://www.jplayer.org/2.1.0/js",
        supplied: "mp3, oga"
    });
});

function eventListeners(){
  $('#mic').on('click', showClipModal)
  $('.close-new-clip').on('click', closeClipModal)
};

function showClipModal(){
  $('.modal').fadeIn()
}

function closeClipModal(){
  $('.modal').fadeOut()
}