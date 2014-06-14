$(document).ready(function(){
  eventListeners();
});

function eventListeners(){
  $('#mic').on('click', showClipModal)
  $('.close-new-clip').on('click', closeClipModal)
};

function showClipModal(){
  $('.modal').fadeIn()
}

function closeClipModal(){
  $('.modal').fadeOut()
}