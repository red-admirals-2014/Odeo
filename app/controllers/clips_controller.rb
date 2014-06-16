
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
    # next_song_really = Clip.find(next_song.clip_id).clip_link
    p "These are our params"
    p params

    if params[:url] = ""
      next_song = Clip.all.sample
      render :text => next_song.clip_link
    else
      clip = Clip.where(clip_link: params[:url]).first
      next_song = Clip.all.sample#.votes.where.not(user_id: 1).first
      if params[:vote] == 'upvote'
        vote = Vote.new(user_id: session[:user_id], clip_id: clip.id, like: true)
      else
        vote = Vote.new(user_id: session[:user_id], clip_id: clip.id, like: false)
      end
    if vote.save
      render :text => next_song.clip_link
    else
      render :text => next_song.clip_link
    end
  end

end

end