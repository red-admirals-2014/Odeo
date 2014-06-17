// Modal View

function View(){

}

function Modal(){};

Modal.prototype = {
  showModal: function(){
    $('.modal').fadeIn();
    $(".no-clips").hide();
  },

  closeModal: function(){
    $('.modal').fadeOut();
    $(".no-clips").show();
  },

  updateSubmitFormAction: function(action_url){
    $('#clip_upload').attr('action', action_url);
  }

};

// End of Clips View
function noClips(){};

noClips.prototype = {
  showNoClips: function(){
    $('.modal').fadeIn();
    $(".clip-form").hide();
  },

  closeNoClips: function(){
    $('.modal').fadeOut();
    $(".clip-form").show();
  }
};

