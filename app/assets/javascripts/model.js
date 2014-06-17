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
      apiKey = key;
    })
    return apiKey;
  },
  getApiKey: function(){
    return this.apikey;
  }
}