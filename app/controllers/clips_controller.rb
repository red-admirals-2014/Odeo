
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

    if params[:url] == "https://srv23.cloudconvert.org/download/i7F82KLc"
      potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', session[:user_id]).references(:votes)
      all_clips = Clip.all
      possible_songs = all_clips - voted_on
      next_song = possible_songs.sample
      p "This is the next song"
      p next_song
      render :text => next_song.clip_link, layout: false
    else
       potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', session[:user_id]).references(:votes)
      all_clips = Clip.all
      possible_songs = all_clips - voted_on
      next_song = possible_songs.sample
      p "This is the next song"
      p next_song
      clip = Clip.where(clip_link: params[:url]).first
  #       potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      if params[:vote] == 'upvote'
        vote = Vote.create(user_id: session[:user_id], clip_id: clip.id, like: true)
        render :text => next_song.clip_link, layout: false
      else
        vote = Vote.create(user_id: session[:user_id], clip_id: clip.id, like: false)
        render :text => next_song.clip_link, layout: false
      end
#     next_song = potential_next_songs.find  { |song| song.votes.where.not(user_id: session[:user_id])}
#     p "This is the next song"
#     p next_song
  end

  end

end