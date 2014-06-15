function Modal(){};

Modal.prototype = {
  showModal: function(){
    $('.modal').fadeIn();
  },

  closeModal: function(){
    $('.modal').fadeOut();
  }
};


function Play(){};

Play.prototype = {
  playSong: function(){
    $("#jquery_jplayer_1").jPlayer({
      ready: function(){
        $(this).jPlayer("setMedia", {
         m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a",
        });
      },
      supplied: "m4a"
    });
  }
}


