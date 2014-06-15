$(document).ready(function(){
  $("form").on('submit', cloudConvert)
  var files;
  $('input[type=file]').on('change', prepareUpload);
  function prepareUpload(event) {
    files = event.target.files;
  }

var cloudConvert = function(event) {
  event.stopPropogation
  event.preventDefault()

  var data = new FormData();
  $.each(files, function(key, value){
    data.append(key, value);
  });
debugger
  converter = $.ajax({
    url: e.target.action,
    type: 'POST',
    data: data,
    processData: false
  })

  converter.done(function(data) {
    console.log("working")
    console.log(e.target.action)
  })

  converter.fail(function(jqXHR, textStatus, errorThrown) {
    console.log("failed")
    console.log(e.target.action)
  })
};
});