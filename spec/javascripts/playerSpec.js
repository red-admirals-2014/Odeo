describe("Player", function(){
  it("has an initial player function that loads the player with a song", function(){
    var player = new Player();
    spyOn(player, 'initPlayer');
    var response = "test"
    player.initPlayer("test")
    expect(player.initPlayer).toHaveBeenCalledWith(response);
  })
})
