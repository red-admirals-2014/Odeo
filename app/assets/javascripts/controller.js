function Controller(modal, play, clip, cloudApi){
  this.modalView = modal;
  this.playView = play;
  this.cloudApi = cloudApi;
}

Controller.prototype = {
  bindEventListener: function(){
     $('.click-vote').on('click','.b-med', this.openModal.bind(this) );
     $('.close-new-clip').on('click', this.closeModal.bind(this) );
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
    this.playView.pauseSong();
  },

  closeModal: function(){
    this.modalView.closeModal();
    this.playView.unpauseSong();
  },


  triggerPlay: function(){
    this.playView.initPlayer();
  },
  setProcessIdToSubmitForm: function(){
    $.ajax({
      url: 'https://api.cloudconvert.org/process',
      type: 'POST',
      data: {
        apikey: this.cloudApi.getKey(),
        inputformat: 'wav',
        outputformat: 'mp3'
      }
    }).done(function(response){
      var upload_form_action = "https:" + response.url;
      this.modalView.updateSubmitFormAction(upload_form_action);
    })
  },
  voteHandler: function(event, data){
    console.log("**** IN VOTE HANDLER ****");
    console.log(event.target.id);
    // debugger
    this.playView.playNextSong(event);
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
