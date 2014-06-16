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


// Play View
function Play(){
  this.player = $("#jquery_jplayer_1");
};

Play.prototype = {
  playSong: function(){
    this.player.jPlayer({
      ready: function(){
        $(this).jPlayer("setMedia", {
         mp3: "https://srv23.cloudconvert.org/download/hfJe5Xy9",
        });
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
      console.log("**** INSIDE DONE OF PLAY NEXT SONG ****")
      console.log(response)
      this.player.jPlayer("setMedia", {
        mp3: response
      })
      this.player.jPlayer("play")
    }.bind(this))
  }
};
