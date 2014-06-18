// Play View
function Player(){
  this.player = $("#jquery_jplayer_1");
};

Player.prototype = {
  initPlayer: function(response){
    this.player.jPlayer({
      ready: function(response){
        $(this).jPlayer("setMedia", {
         mp3: "https://s3-us-west-1.amazonaws.com/akfoster/users/Music/01-03-+Dirt+and+Roses.mp3",
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
      if (response === "end") {
        console.log("WE MADE IT!")
        this.pauseSong;
        $('#open-no-clips').trigger('click');
      }
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
