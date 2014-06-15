// var FileSubmission = {
//   bindEvents: function() {
//     $('#clip_upload').ajaxForm().done(function(data){
//         console.log("inside done ***********");
//         console.log( data )
//       })
//   },

// }

// $(document).ready(function(){
//   FileSubmission.bindEvents();
// })

$(document).ready(function(){
  var options = {
    target:     '.modal-content h1',
    success:    successResponse,
    dataType:   'json'
  };
  $('#clip_upload').ajaxForm(options);
})

function successResponse(responseText, statusText, xhr, $form) {
  console.log("***** IN SUCCESS RESPONSE *****")
  console.log(responseText.);
}