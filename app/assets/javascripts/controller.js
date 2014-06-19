function Controller(modal, play, cloudApi, view, noClip){
  this.modalView = modal;
  this.player = play;
  this.cloudApi = cloudApi;
  this.view = view;
  this.noClip = noClip;
}

Controller.prototype = {
  bindEventListener: function(){
     $(this.view.micButton).on('click', this.openModal.bind(this) );
     $(this.view.closeNewClipModal).on('click', this.closeModal.bind(this) );
     $(this.view.closeNoClipsModal).on('click', this.closeNoClips.bind(this) );
     $(this.view.openNoClipsModal).on('click', this.showNoClips.bind(this) );
     $(this.view.cassette).on('click', this.triggerPlay.bind(this) );
     $(this.view.voteButtons).on('click', this.voteHandler.bind(this));
     $(this.view.clipUpload).ajaxForm({
        success: returnDownloadLink,
        error: errorUploadingClip
     });
     $(this.view.player).on('swipeleft', this.voteHandler.bind(this))
     $(this.view.player).on('swiperight', this.voteHandler.bind(this))
     $(this.view.submitButton).on('click', this.showPending.bind(this) );
     $(this.view.cassette).trigger('click');
  },
  openModal: function(){
    this.modalView.showModal();
    this.player.pauseSong();
    this.setProcessIdToSubmitForm();
  },
  closeModal: function(){
    this.modalView.closeModal();
    this.player.unpauseSong();
  },
  closeNoClips: function(){
    this.noClip.closeNoClips();
  },
  showNoClips: function() {
    this.noClip.showNoClips();
  },
  triggerPlay: function(){
    this.player.initPlayer();
  },
  setProcessIdToSubmitForm: function(){
    var apiKey = this.cloudApi.getKey();
    var process_id = this.cloudApi.getNewProcess(apiKey);
    this.modalView.updateSubmitFormAction(process_id);
  },
  voteHandler: function(event){
    if (event.type === "swipeleft") {
      voteStatus = "downvote"
    } else if (event.type === "swiperight") {
      voteStatus = "upvote"
    } else {
      voteStatus = event.currentTarget.id
    }
    this.player.voteAndPlayNextSong(voteStatus, this.view.upVoteDownVote);
  },
  showPending: function(){
    this.view.displayPendingUpload();
  }
};
function returnDownloadLink(){
  $('.upload-pending').fadeOut();
  $('.upload-success').fadeIn();
  $.getJSON(this.url, function(data) {
    var returnedUrl = data['output'].url
    insertIntoDatabase(returnedUrl)
  });
};
function errorUploadingClip(){
  $(this.view.uploadPending).fadeOut()
  $(this.view.uploadError).fadeIn()
};
function insertIntoDatabase(returnedURL){
  $.ajax({
    url: "/clips",
    type: "POST",
    data: {url: returnedURL}
  })
};


