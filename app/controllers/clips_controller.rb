
class ClipsController < ApplicationController
  include HTTParty
  
  def index
  end

  def new
    @response = HTTParty.post("https://api.cloudconvert.org/process?apikey=#{ENV['CLOUD_API_KEY']}&inputformat=wav&outputformat=mp3")
    puts @response['url']
  end

end