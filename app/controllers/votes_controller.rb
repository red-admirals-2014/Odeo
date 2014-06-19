class VotesController < ApplicationController

	def create
    p "these are your params"
    p params
    song_url = params[:url]
    base_song_url = "https://s3-us-west-1.amazonaws.com/akfoster/users/Music/01-03-+Dirt+and+Roses.mp3"
    user_vote = params[:vote]
    clip = Clip.find_by_clip_link(song_url)

    if song_url != base_song_url && clip != nil
      if user_vote == 'upvote'
        clip.votes.create(user_id: current_user.id, like: true)
        render :text => "upvote", layout: false
      elsif user_vote == 'downvote'
        clip.votes.create(user_id: current_user.id, like: false)
        render :text => "downvote", layout: false
      end
    else
      p "Now I am here!"
      render :text => "error", layout: false
    end
	end
end