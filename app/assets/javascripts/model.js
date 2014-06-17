function CloudAPI(){
  this.apikey = this.getKey();
}

CloudAPI.prototype = {
  getKey: function(){
    var apiKey;
    $.ajax({
      url: '/cc_apikey',
      type: 'GET',
      async: false
    }).done(function(key){
      console.log(key)
      apiKey = key;
      console.log(apiKey)
    })
    return apiKey;
  },
  getApiKey: function(){
    return this.apikey;
  }
}