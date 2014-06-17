// Play View
function Player(){
  this.player = $("#jquery_jplayer_1");
};

Player.prototype = {
  initPlayer: function(response){
    this.player.jPlayer({
      ready: function(response){
        $(this).jPlayer("setMedia", {
         mp3: "https://srv23.cloudconvert.org/download/i7F82KLc",
        }).jPlayer("play");
      },
      supplied: "mp3"
    });
  },
  playNextSong: function(event){
    $.ajax({
      url: '/votes/create',
      type: 'POST',
      data: {
        url: this.player.jPlayer()[0].lastChild.src,
        vote: event.target.id
      }
    });
    $.ajax({
      url: '/clips/next',
      type: 'GET',
    }).done(function(response){
      console.log("************ response *********")
      console.log(response)
      this.player.jPlayer("setMedia",{
        mp3: response
      }).jPlayer("play")
    }.bind(this))
  },

  pauseSong: function(){
    this.player.jPlayer("pause")
  },

  unpauseSong: function(){
    this.player.jPlayer("play")
  }
};
