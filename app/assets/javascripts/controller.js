function Controller(modal, play, clip){
  this.modalView = modal
  this.playView = play
}

Controller.prototype = {
  bindEventListener: function(){

     $('#mic').on('click', this.openModal.bind(this) );
     $('.close-new-clip').on('click', this.closeModal.bind(this) );
     $('#cassette').on('click', this.triggerPlay.bind(this) );
     $('.click-vote').on('click', this.voteHandler.bind(this));
     $('#clip_upload').ajaxForm({
        success: returnDownloadLink,
        error: errorUploadingClip
     });
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

  voteHandler: function(event, data){
    console.log("**** IN VOTE HANDLER ****");
    console.log(event.target.id);
    this.playView.playNextSong();
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
  // difficult to test when cloud convert can basically accept
  // all file types. We will need to set a limit for the upload.
};

function insertIntoDatabase(returnedURL){
  $.ajax({
    url: "/clips",
    type: "POST",
    data: {url: returnedURL}
  }).success(displayInfo)
};

function displayInfo(data){
};