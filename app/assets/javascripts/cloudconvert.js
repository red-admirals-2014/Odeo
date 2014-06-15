$(document).ready(function(){
  	var options = {
  		success : returnDownloadLink,
  		error : errorUploadingClip
  	}
  $('#clip_upload').ajaxForm(options)
})

function returnDownloadLink(){
	$.getJSON(this.url, function(data) {
		console.log(data['output'].url)
	})
}

function errorUploadingClip(){
	console.log("Yikes, we can't upload that!")
	debugger
}
