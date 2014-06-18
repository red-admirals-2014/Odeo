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
  },

  displayPendingUpload: function(){
    $('.upload-pending').fadeIn(300)
  }
}

function Modal(){};

Modal.prototype = {
  showModal: function(){
    $('.modal').fadeIn(300);
    $(".no-clips").hide();
  },

  closeModal: function(){
    $('.modal').fadeOut(300);
    $('.upload-success').fadeOut(300);
    $('.upload-error').fadeOut(300);
    $(".no-clips").show();
  },

  updateSubmitFormAction: function(action_url){
    $('#clip_upload').attr('action', action_url);
  }

};

// End of Clips View
function noClips(){};

noClips.prototype = {
  showNoClips: function(){
    $('.modal').fadeIn();
    $(".clip-form").hide();
  },

  closeNoClips: function(){
    $('.modal').fadeOut();
    $(".clip-form").show();
  }
};

