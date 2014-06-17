function CloudAPI(){
  this.apikey = this.getKey();
}

CloudAPI.prototype = {
  getKey: function(){
    var singleLadies;
    $.ajax({
      url: '/cc_apikey',
      type: 'GET',
      async: false
    }).done(function(key){
      singleLadies = key;
    })
    return singleLadies;
  },
  getApiKey: function(){
    return this.apikey;
  }
}