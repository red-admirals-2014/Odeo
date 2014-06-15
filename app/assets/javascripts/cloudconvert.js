$(document).ready(function(){
  $('#clip_upload').ajaxForm(myFormAction)
})

function myFormAction(){
	$.getJSON(this.url, function(data) {
		console.log(data['output'].url)
	})
}
