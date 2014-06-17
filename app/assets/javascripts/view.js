// Modal View

function View(){

}

function Modal(){};

Modal.prototype = {
  showModal: function(){
    $('.modal').fadeIn();
  },

  closeModal: function(){
    $('.modal').fadeOut();
  }
};

// End of Clips View
function NoClips(){};

NoClips.prototype = {
  showNoClips: function(){
    $('.modal .no-clips').fadeIn();
  },

  closeNoClips: function(){
    $('.modal .no-clips').fadeOut();
  }
};

  },
  updateSubmitFormAction: function(action_url){
    $('#clip_upload').attr('action', action_url);
  }
};
