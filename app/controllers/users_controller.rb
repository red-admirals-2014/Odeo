class UsersController < ApplicationController

  # def new
  #   client = SoundCloud.new(:client_id => ENV['YOUR_CLIENT_ID'],
  #                           :client_secret => ENV['YOUR_CLIENT_SECRET'],
  #                           :redirect_uri => ENV['REDIRECT_URL'])
  #   redirect_to client.authorize_url()
  # end

  def create
    # create client object with app credentials
    client = Soundcloud.new(:client_id => ENV['YOUR_CLIENT_ID'],
                            :client_secret => ENV['YOUR_CLIENT_SECRET'],
                            :redirect_uri => ENV['REDIRECT_URL'],
                            :username => 'akknits@gmail.com',
                            :password => 'sdbctestd')
    redirect_to client.authorize_url()

    # exchange authorization code for access token
    code = params[:code]
    puts "*" * 50
    puts params
    puts code
    puts "*" * 50
    access_token = client.exchange_token(:code => code)
    User.create(user_name: "me", access_token: access_token[access_token], refresh_token: access_token[refresh_token], expires_in: access_token[expires_in], scope: access_token[scope])
  end

end