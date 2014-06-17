class VotesController < ApplicationController

	def create
    p "These are our params"
    p params
    song_url = params[:url]
    base_song_url = "https://srv23.cloudconvert.org/download/i7F82KLc"
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
      render :text => "error: something went wrong", layout: false
    end
	end
end