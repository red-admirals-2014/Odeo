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
  },
  updateSubmitFormAction: function(action_url){
    $('#clip_upload').attr('action', action_url);
  }
};