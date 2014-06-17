
class ClipsController < ApplicationController

  def index
  end

  def new

  end

  def create
    user = User.find(session[:user_id])
    # CR you don't need this - you can use current_user

    clip = user.clips.new(clip_link: params[:url])

    if clip.save #CR  && params[:error]=nil
      redirect_to root_path
    else
      # CR Check your json object client side for error from cloudconvert and make sure to send that along so you can actually have a fail .- ie wrap your API calls in a MVC or MC

      puts "This failed"
    end
  end
# CR a clip does not have an API key - application controller works.

  def apikey
    render :text => ENV['CLOUD_API_KEY']
  end

# CR next clip is really create vote. Move this to the vote controller #create .  And then refactor to model. Clip.next lives on the clip model.

  def next
    # next_song_really = Clip.find(next_song.clip_id).clip_link
    p "These are our params"
    p params
# CR "https://srv23.cloudconvert.org/download/i7F82KLc" is a magic_string Create a Clip.base_song_url variable on the Clip model.
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
      next_song
    else
      next_song
    end
end

# CR refactor - start by making a next_song method - roughly like this - then evaluate moving to Clip model.  Clean up vocabulary song = clip.
def next_song

      potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      # CR create a model method or scopes recent_clips
      voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', session[:user_id]).references(:votes)
      # CR refactor - don't put sessions in AR (current_user.id)
      possible_songs = potential_next_songs - voted_on
      # CR - subtracting arrays is a code smell - do directly in AR.
      next_song = possible_songs.sample
      p "This is the next song"
      p next_song
      render :text => next_song.clip_link, layout: false
  end
    # if params[:url] == "https://srv23.cloudconvert.org/download/i7F82KLc"
    #   potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
    #   voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', session[:user_id]).references(:votes)
    #   possible_songs = potential_next_songs - voted_on
    #   next_song = possible_songs.sample
    #   p "This is the next song"
    #   p next_song
    #   render :text => next_song.clip_link, layout: false
    # else
    #    potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
    #   voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', session[:user_id]).references(:votes)
    #   all_clips = Clip.all
    #   possible_songs = all_clips - voted_on
    #   next_song = possible_songs.sample
    #   if next_song
    #     p "This is the next song"
    #     p next_song
    #     render :text => next_song.clip_link, layout: false
    #   else
    #     render :text => "end", layout: false
    #   # render :text => "you've exhausted all songs"
    #   end
  #       potential_next_songs = Clip.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
  #   end
  # end

end
