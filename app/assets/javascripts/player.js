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

  voteAndPlayNextSong: function(status, callback){
    $.ajax({
      url: '/votes/create',
      type: 'POST',
      data: {
        url: this.player.jPlayer()[0].lastChild.src,
        vote: status
      }
    }).done(function() {
      this.playNextSong(function() {
        callback(status)
      }.bind(this));
    }.bind(this));
  },

  playNextSong: function(callback) {
    $.ajax({
      url: '/clips/next',
      type: 'GET',
    }).done(function(response){
      if (response === "end") {
        this.pauseSong();
        $('#open-no-clips').trigger('click');
      } else {
        callback();
        this.player.jPlayer("setMedia",{
          mp3: response
        }).jPlayer("play")
      }
    }.bind(this))
  },

  pauseSong: function(){
    this.player.jPlayer("pause")
  },

  unpauseSong: function(){
    this.player.jPlayer("play")
  }
};
