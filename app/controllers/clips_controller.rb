
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


  def next
    p "these are our params"
    p params
    @clip = Clip.where(clip_link: params[:url]).first
    if params[:vote] = 'upvote'
      Vote.create(user_id: session[:user_id], clip_id: @clip.id, like: true)
    else
      Vote.create(user_id: session[:user_id], clip_id: @clip.id, like: false)
    end
    @next_song = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day).sample.votes.where.not(user_id: 1).first
    @next_song_really = Clip.find(@next_song.clip_id).clip_link 

    render :text => @next_song_really
    # logic to make sure they don't vote on the same song twice
  end

end