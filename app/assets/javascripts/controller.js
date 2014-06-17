function Controller(modal, play, cloudApi, noClip){
  this.modalView = modal;
  this.player = play;
  this.cloudApi = cloudApi;
  this.noClip = noClip
}

Controller.prototype = {
  bindEventListener: function(){
     $('.click-vote').on('click','.b-med', this.openModal.bind(this) );
     $('.close-new-clip').on('click', this.closeModal.bind(this) );
     $('.close-no-clips').on('click', this.closeNoClips.bind(this) );
     debugger
     $('.no-clips').on('click', this.showNoClips.bind(this) );
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
    })
  },
  voteHandler: function(event, data){
    console.log("**** IN VOTE HANDLER ****");
    console.log(event.target.id);
    // debugger
    this.player.playNextSong(event);
  }
} //End controller prototype



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
