$(document).ready(function(){
	var model = new votesModel
	var view = new votesView
	var controller = new votesController(view, model)
	controller.bindListeners()

})

////////////////////////Controller
var votesController = function(view, model){
	this.view = view //creates the buttons- done
	this.model = model // will perform the logic of voting

}

votesController.prototype = {
	bindListeners: function(){
		this.view.upVote.on("click", this.model.upVoteClip)
		this.view.downVote.on("click", this.downVoteClip)

	},
}



////////////////////////Model
var votesModel = function(){

//Capture the user_id from the soundclip

}
votesModel.prototype = {

	upVoteClip: function(){
		debugger
		
	},

	downVoteClip: function(){
		
	}

}




////////////////////////View
var votesView = function(){
	this.upVote = $('[data-ui="upVote"]')
	this.downVote = $('[data-ui="downVote"]')
	this.songClip = $('.soundClip')
}





