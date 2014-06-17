function Controller(modal, play, clip){
  this.modalView = modal
  this.playView = play
}

Controller.prototype = {
  bindEventListener: function(){
    // CR use the view to set selectors this.view.voteSelector = '.click_vote'
     $('.click-vote').on('click','.b-med', this.openModal.bind(this) );
     $('.close-new-clip').on('click', this.closeModal.bind(this) );
     $('#cassette').on('click', this.triggerPlay.bind(this) );
     $('.click-vote').on('click', '.vote-button', this.voteHandler.bind(this));
     $('#clip_upload').ajaxForm({
        success: returnDownloadLink,
        error: errorUploadingClip
     });
     // Move this to initialize
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
    // get the apikey on initailize and store it.
    $.ajax({
      url: '/cc_apikey',
      type: 'GET'
    }).done(function(key){
      // Use your api wrapper class here - call processclip() here
      $.ajax({
        url: 'https://api.cloudconvert.org/process',
        type: 'POST',
        data: {
          apikey: key,
          inputformat: 'wav',
          outputformat: 'mp3'
        }
      }).done(function(response){
        // move this to the view and model - something testable on the model - getUrl, view.updateForm
        var upload_form_action = "https:" + response.url
        $('#clip_upload').attr('action', upload_form_action)
      })
    })
  },
  voteHandler: function(event, data){
    console.log("**** IN VOTE HANDLER ****");
    console.log(event.target.id);
    // debugger
    // CR playNextSong should be a controller action
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
