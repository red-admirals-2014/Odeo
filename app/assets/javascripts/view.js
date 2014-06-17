// Modal View

function Modal(){};

Modal.prototype = {
  showModal: function(){
    $('.modal').fadeIn();
  },

  closeModal: function(){
    $('.modal').fadeOut();
  }
};

// CR put this in it's own file and call it Player (not playView)

// Play View
function Play(){
  this.player = $("#jquery_jplayer_1");
};

Play.prototype = {
  initPlayer: function(response){
    console.log("**** INSIDE DONE OF PLAY SONG ****")
    this.player.jPlayer({
      ready: function(response){
         console.log('hi')
        $(this).jPlayer("setMedia", {
         mp3: "https://srv23.cloudconvert.org/download/i7F82KLc",
        }).jPlayer("play");
      },
      supplied: "mp3"
    });
  },
  playNextSong: function(event){
    console.log('**** INSIDE PLAY NEXT SONG ****')
    $.ajax({
      url: '/clips/next',
      type: 'GET',
      data: {url: this.player.jPlayer()[0].lastChild.src, vote: event.target.id}
    }).done(function(response){
      if (response ==="end"){
        console.log("We made it to the end!")
        ////// DAN!!!! We need to get that partial in here to tell the user they've exhausted all their songs!
      }
      console.log("**** INSIDE DONE OF PLAY NEXT SONG ****")
      console.log(response)
      this.player.jPlayer("setMedia", {
        mp3: response
      })
      this.player.jPlayer("play")
    }.bind(this))
  },

  pauseSong: function(){
    this.player.jPlayer("pause")
  },

  unpauseSong: function(){
    this.player.jPlayer("play")
  }
};
