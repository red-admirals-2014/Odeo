function CloudAPI(){
  this.apikey = this.getKey();
}

CloudAPI.prototype = {
  getKey: function(){
    var api_key;
    $.ajax({
      url: '/cc_apikey',
      type: 'GET'
    }).done(function(key){
      api_key = key;
    })
    return api_key;
  }
}