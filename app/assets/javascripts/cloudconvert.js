$(document).ready(function(){
  	var options = {
  		success : returnDownloadLink,
  		error : errorUploadingClip
  	}
  $('#clip_upload').ajaxForm(options)
})

function returnDownloadLink(){
	$.getJSON(this.url, function(data) {
	debugger
		var returnedUrl = data['output'].url
		insertIntoDatabase(returnedUrl)
	})
}

function errorUploadingClip(){
	console.log("Yikes, we can't upload that!")
	// difficult to test when cloud convert can basically accept
	// all file types. We will need to set a limit for the upload.
}

function insertIntoDatabase(returnedURL){
	$.ajax({
		// url: "/users/" +  + "/clips(.:format)",
		type: "POST", 
		data: returnedURL
	}).success(displayInfo)
}

function displayInfo(data){
	debugger
}