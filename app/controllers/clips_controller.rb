
class ClipsController < ApplicationController
  def index
  end

  def create
    clip = current_user.clips.new(clip_link: params[:url])

    if clip.save && params[:error] == nil
      redirect_to root_path
    else
      # CR Check your json object client side for error from cloudconvert and make sure to send that along so you can actually have a fail .- ie wrap your API calls in a MVC or MC
      puts "This failed"
    end
  end

  # CR next clip is really create vote. Move this to the vote controller #create .  And then refactor to model. Clip.next lives on the clip model.

  def next
    if params[:url] == "https://srv23.cloudconvert.org/download/i7F82KLc"
      potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', current_user).references(:votes)
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
      end
    end
  end

end