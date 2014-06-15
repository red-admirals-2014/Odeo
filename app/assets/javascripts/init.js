$(document).ready(function(){
  eventListeners();


	$("#jquery_jplayer_1").jPlayer({
	ready: function () {
	$(this).jPlayer("setMedia", {
	title: "Bubble",
	m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a",
	oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
	});
	},
	swfPath: "/js",
	supplied: "m4a, oga"
	});
});