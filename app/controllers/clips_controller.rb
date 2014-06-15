
class ClipsController < ApplicationController

  def index
    @response = HTTParty.post("https://api.cloudconvert.org/process?apikey=#{ENV['CLOUD_API_KEY']}&inputformat=wav&outputformat=mp3")
    puts @response['url']
    @cloudconvert = Cloud.new
  end

  def new

  end

  def create
    user = User.find(session[:user_id])
    clip = user.clips.new(clip_link: params[:url])

    if clip.save
      redirect_to root_path
    else
      puts "This failed"
    end
  end

end