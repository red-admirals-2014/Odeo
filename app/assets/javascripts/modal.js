$(document).ready(function(){
  eventListeners();
});

function eventListeners(){
  $('#mic').on('click', showClipModal)
  $('.close-new-clip').on('click', closeClipModal)
};

function showClipModal(){
  $('.modal').css('display', 'initial')
}

function closeClipModal(){
  $('.modal').css('display', 'none')
}