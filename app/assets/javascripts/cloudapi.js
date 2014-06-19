function CloudAPI(){
  this.ccApiKeyRoute = '/cc_apikey';
  this.ccProcessUrl = 'https://api.cloudconvert.org/process';
}

CloudAPI.prototype = {
  getKey: function(){
    $.ajax({
      url: this.ccApiKeyRoute,
      type: 'GET',
      async: false
    }).done(function(key){
      apiKey = key;
    })
    return apiKey;
  },
  getNewProcess: function(apiKey){
    $.ajax({
      url: this.ccProcessUrl,
      type: 'POST',
      data: {
        apikey: apiKey,
        inputformat: 'wav',
        outputformat: 'mp3'
      },
      async: false
    }).done(function(response){
      process_url = "https:" + response.url;
    })
    return process_url;
  }
}

