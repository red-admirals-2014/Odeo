function Controller(modal, play, cloudApi, view, noClip){
  this.modalView = modal;
  this.player = play;
  this.cloudApi = cloudApi;
  this.view = view;
  this.noClip = noClip;

}

Controller.prototype = {
  bindEventListener: function(){
     $('.click-vote').on('click','.b-med', this.openModal.bind(this) );
     $('.close-new-clip').on('click', this.closeModal.bind(this) );
     $('.close-no-clips').on('click', this.closeNoClips.bind(this) );
     $('#open-no-clips').on('click', this.showNoClips.bind(this) );
     $('.pending').on('click', this.showPending.bind(this) );
     $('#cassette').on('click', this.triggerPlay.bind(this) );
     $('.click-vote').on('click', '.vote-button', this.voteHandler.bind(this));
     $('#clip_upload').ajaxForm({
        success: returnDownloadLink,
        error: errorUploadingClip
     });
     $('#cassette').trigger('click');
     },
  openModal: function(){
    this.modalView.showModal();
    this.player.pauseSong();
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
    var key = this.cloudApi.getKey();
    var self = this;
    $.ajax({
      url: 'https://api.cloudconvert.org/process',
      type: 'POST',
      data: {
        apikey: key,
        inputformat: 'wav',
        outputformat: 'mp3'
      }
    }).done(function(response){
      var upload_form_action = "https:" + response.url;
      self.modalView.updateSubmitFormAction(upload_form_action);

      // Uploaded at Cloud Converter... Msg:
    })
  },
  voteHandler: function(event){
    voteStatus = event.currentTarget.id
    this.view.upVoteDownVote(voteStatus)
    this.player.playNextSong(event);
  },

  showPending: function(){
    this.view.displayPendingUpload();
  }
};



function returnDownloadLink(){
  $.getJSON(this.url, function(data) {
    var returnedUrl = data['output'].url
    insertIntoDatabase(returnedUrl)
  });
  $('.upload-pending').fadeOut(300)
  $('.upload-success').fadeIn(300)

};

function errorUploadingClip(){
  console.log("Yikes, we can't upload that!")
  $('.upload-pending').fadeOut(300)
  $('.upload-error').fadeIn(300)
};

function insertIntoDatabase(returnedURL){
  $.ajax({
    url: "/clips",
    type: "POST",
    data: {url: returnedURL}
  }).success(displayInfo)
};

function displayInfo(data){};
