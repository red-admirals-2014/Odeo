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
    //get process id from cc api that returns the id
    var apiKey = this.cloudApi.getKey();
    var process_id = this.cloudApi.getNewProcess(apiKey);
    this.modalView.updateSubmitFormAction(process_id);
  },
  voteHandler: function(event){
    voteStatus = event.currentTarget.id
    this.view.upVoteDownVote(voteStatus)
    this.player.playNextSong(event);
  }
}

function returnDownloadLink(){
  $.getJSON(this.url, function(data) {
    var returnedUrl = data['output'].url
    insertIntoDatabase(returnedUrl)
  })
};

function errorUploadingClip(){
  console.log("Yikes, we can't upload that!")
};

function insertIntoDatabase(returnedURL){
  $.ajax({
    url: "/clips",
    type: "POST",
    data: {url: returnedURL}
  }).success(displayInfo)
};

function displayInfo(data){};
