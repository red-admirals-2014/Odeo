
class ClipsController < ApplicationController

  def index
  end


  def create
    user = User.find(session[:user_id])
    clip = user.clips.new(clip_link: params[:url])

    if clip.save
      redirect_to root_path
    else
      puts "This failed"
      redirect_to root_path
    end
  end

  def apikey
    render :text => ENV['CLOUD_API_KEY']
  end

  def next
    # next_song_really = Clip.find(next_song.clip_id).clip_link
    p "These are our params"
    p params

    unless params[:url] == "https://srv23.cloudconvert.org/download/i7F82KLc"
      clip = Clip.where(clip_link: params[:url]).first
      if params[:vote] == 'upvote'
        vote = Vote.create(user_id: session[:user_id], clip_id: clip.id, like: true)
        # render :text => next_song.clip_link, layout: false
      elsif params[:vote] == 'downvote'
        vote = Vote.create(user_id: session[:user_id], clip_id: clip.id, like: false)
        # render :text => next_song.clip_link, layout: false
      else
        render :text => "https://srv23.cloudconvert.org/download/i7F82KLc", layout: false
      end
    end

    if params[:url] == "https://srv23.cloudconvert.org/download/i7F82KLc"
      potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', session[:user_id]).references(:votes)
      possible_songs = potential_next_songs - voted_on
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
      if next_song
        p "This is the next song"
        p next_song
        render :text => next_song.clip_link, layout: false
      else
        render :text => "end", layout: false
      # render :text => "you've exhausted all songs"
      end
  #       potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
    end
  end

end