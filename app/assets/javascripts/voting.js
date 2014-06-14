$(document).ready(function(){
	var model = new votesModel
	var view = new votesView
	var controller = new votesController(view, model)
})

////////////////////////Controller
var votesController = function(view, model){
	this.view = view //creates the buttons
	this.model = model // will perform the logic of voting

}




////////////////////////Model
var votesModel = function(){

}






////////////////////////View
var votesView = function(){
	this.upVote = $('[data-ui="upVote"]')
	this.downVote = $('[data-ui="downVote"]')
}





