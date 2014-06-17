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
  },

  closeModal: function(){
    $('.modal').fadeOut();
  },
  updateSubmitFormAction: function(action_url){
    $('#clip_upload').attr('action', action_url);
  }
};