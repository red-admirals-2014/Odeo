describe("CloudAPI", function(){
  beforeEach(function(){
    cloudApi = new CloudAPI();
  })

  it("has a cloud convert api key route defined", function(){
    expect(cloudApi.ccApiKeyRoute).toBe('/cc_apikey');
  });

  it("has a cloud convert process url defined", function(){
    expect(cloudApi.ccProcessUrl).toBe('https://api.cloudconvert.org/process');
  });

  it("hits our apikey route to get our CC apikey", function(){
    var promise = {
      done: function(callback) {
        callback("foobar")
      }
    }

    spyOn(promise, "done").and.callThrough()
    spyOn($, "ajax").and.returnValue(promise)

    expect(cloudApi.getKey()).toEqual("foobar")

    expect($.ajax).toHaveBeenCalledWith({
      url: cloudApi.ccApiKeyRoute,
      type: "GET",
      async: false
    });

    expect(promise.done).toHaveBeenCalled()
  });

})