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
      console.log(key)
      singleLadies = key;
      console.log(singleLadies)
    })
    return singleLadies;
  },
  getApiKey: function(){
    return this.apikey;
  }
}