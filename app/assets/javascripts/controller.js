function Controller(modal, play, clip){
  this.modalView = modal
  this.playView = play
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
  },

  closeModal: function(){
    this.modalView.closeModal();
  },

  triggerPlay: function(){
    this.playView.playSong();
  },
  setProcessIdToSubmitForm: function(){
    $.ajax({
      url: '/cc_apikey',
      type: 'GET'
    }).done(function(key){
      $.ajax({
        url: 'https://api.cloudconvert.org/process',
        type: 'POST',
        data: {
          apikey: key,
          inputformat: 'wav',
          outputformat: 'mp3'
        }
      }).done(function(response){
        var upload_form_action = "https:" + response.url
        $('#clip_upload').attr('action', upload_form_action)
      })
    })
  },
  voteHandler: function(event, data){
    console.log("**** IN VOTE HANDLER ****");
    console.log(event.target.id);
    //
    // $.ajax({
    //   url: '/votes/create',
    //   type: 'POST'
    // }).done(function(response){
    //   console.log("**** Voted!!! ****")
    //   console.log(response)
    // }.bind(this))

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
