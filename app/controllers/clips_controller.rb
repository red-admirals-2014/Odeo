
class ClipsController < ApplicationController

  def index
    @response = HTTParty.post("https://api.cloudconvert.org/process?apikey=#{ENV['CLOUD_API_KEY']}&inputformat=wav&outputformat=mp3")
    puts @response['url']
    @cloudconvert = Cloud.new
    puts "****************** CLOUD CONVERT ************"
    puts @cloudconvert.process_url
  end

  def new

  end

  def create
    #logic
    if #clip has successfully been created or started uploading

      redirect_to root_path
    else
      #
    end
  end

  def next
    render :text => "https://srv23.cloudconvert.org/download/ZScxGvd2"
  end
end