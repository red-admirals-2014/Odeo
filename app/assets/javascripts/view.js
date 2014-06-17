// Modal View

function View(){}

View.prototype = {
  upVoteDownVote: function(voteStatus){
    if (voteStatus === "upvote"){
      console.log("UPVOTED!")
      // $('body').append('<h1>Win</h1>').clear()

    }
    else {
      console.log("DOWNVOTED!!!")

    }
  }
}

function Modal(){};

Modal.prototype = {
  showModal: function(){
    $('.modal').fadeIn();
    $(".no-clips").hide();
    navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
    });
  },

  closeModal: function(){
    $('.modal').fadeOut();
  },

  updateSubmitFormAction: function(action_url){
    $('#clip_upload').attr('action', action_url);
  }

};

// End of Clips View
function noClips(){};

noClips.prototype = {
  showNoClips: function(){
    $(".no-clips").show();
    $('.modal').fadeIn();
    $(".clip-form").hide();
  },

  closeNoClips: function(){
    $('.modal').fadeOut();
    $(".clip-form").show();
  }
};

