function View(){
  this.micButton = 'img#mic.b-med';
  this.closeNewClipModal = '.close-new-clip';
  this.closeNoClipsModal = '.close-no-clips';
  this.openNoClipsModal = '#open-no-clips';
  this.cassette = '#cassette';
  this.voteButtons = '.click-vote .vote-button';
  this.clipUpload = '#clip_upload';
  this.player ='#jp_container_1';
  this.submitButton = '.submit';
  this.uploadPending = '.upload-pending';
  this.uploadSuccess = '.upload-success';
  this.uploadError = '.upload-error';
}
View.prototype = {
  upVoteDownVote: function(voteStatus){
    if (voteStatus === "upvote"){
      console.log(voteStatus)
      $(".like").fadeIn("medium")
      $(".like").fadeOut("medium")
    }
    else {
      $(".nope").fadeIn("medium")
      $(".nope").fadeOut("medium")
    }
  },

  displayPendingUpload: function(){
    $('.upload-pending').fadeIn()
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
    $('.upload-success').fadeOut();
    $('.upload-error').fadeOut();
  },
  updateSubmitFormAction: function(action_url){
    $('#clip_upload').attr('action', action_url);
  }
};
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

