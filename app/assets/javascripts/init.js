$(document).ready(function(){
  eventListeners();


	$("#jquery_jplayer_1").jPlayer({
		ready: function () {
			$(this).jPlayer("setMedia", {
				m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a",
			});
		},
			supplied: "m4a"
		});
});


// click on button
// ajax request to a route you define
// said route will return a mp3 url
// plug that into your media player function


// $(document).ready( init )

// function init(){
// 	var view = new View
// 	var blueView = new BlueView
// 	var model = new Model
// 	var controller = new Controller( model, view, blueView )
// 	controller.bindEventListeners()
// }


