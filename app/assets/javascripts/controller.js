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

  findNextSong: function(){
    console.log("inside findNextSong")
    var self = this
    $.ajax({
      url: '/clips/next',
      type: 'GET',
      data: {url: this.playView.player.jPlayer()[0].lastChild.src, vote: event.target.id}
    }).done(function(response){
      console.log("inside the response")
      console.log(response)
      self.playView.playSong(response)
    })
  },

  triggerPlay: function(){
    // debugger
    this.findNextSong()
    // this.playView.playSong();
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
